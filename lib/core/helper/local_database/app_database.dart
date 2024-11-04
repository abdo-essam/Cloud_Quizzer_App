import 'package:sqflite/sqflite.dart';

import '../../models/questions.dart';

class AppDatabase {
  static Database? _database;

  static final AppDatabase instance = AppDatabase._init();

  AppDatabase._init();

  Future<Database> get database async {
    _database ??= await openDatabase('appdatabase.db',
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS Questions (
    question_id INTEGER PRIMARY KEY AUTOINCREMENT,
    question_text TEXT NOT NULL,
    answer_index INTEGER NOT NULL,
    options TEXT NOT NULL )
    """);
    for (var i = 0; i < 10; i++) {
      await db.execute("""
    INSERT INTO Questions (question_text, answer_index, options) VALUES ('AWS allows users to manage their resources using a web based user interface. What is the name of this interface?', 3, 'A. AWS CLI,B. AWS API,C. AWS SDK,D. AWS Management Console')
    """);
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await _onCreate(db, newVersion);
    }
  }

  Future<void> insertQuestion(Question question) async {
    final db = await database;
    await db.insert(
      'Questions',
      question.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Question>> getQuestions() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('Questions');

    return List.generate(maps.length, (i) {
      return Question.fromMap(maps[i]);
    });
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
