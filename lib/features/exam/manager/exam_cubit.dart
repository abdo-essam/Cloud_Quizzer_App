import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/helper/local_database/app_database.dart';
import '../../../core/models/bookmark.dart';
import '../../../core/models/certification.dart';
import '../../../core/models/questions.dart';
import '../../../core/services/firebase_service.dart';
import 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit() : super(ExamInitial());

  static ExamCubit get(context) => BlocProvider.of<ExamCubit>(context);

  int _index = 0;
  int _score = 0;
  bool isBookmarked = false;

  List<Question> _questions = [];
  final List<Question> _incorrectQuestionsList = [];
  late Certification _certification;

  int get index => _index;
  int get score => _score;
  List<Question> get questions => List.unmodifiable(_questions);
  List<Question> get incorrectQuestionsList => List.unmodifiable(_incorrectQuestionsList);
  Certification get certification => _certification;

  Future<void> getQuestionsFromFirebase(String certificationCode) async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      final mcqSnapshot = await _firestore
          .collection('categories')
          .doc('cloud')
          .collection(certificationCode)
          .doc('questions')
          .collection('mcq')
          .get();

      final questions = <Question>[];

      for (var doc in mcqSnapshot.docs) {
        try {
          final data = doc.data();
          // Add certification code to the data
          data['certification_code'] = certificationCode;

          if (_validateQuestionData(data)) {
            questions.add(Question.fromFirestore(doc));
          }
        } catch (e) {
          print('Error processing document: $e');
          continue;
        }
      }

      _questions = questions;
      emit(ExamGetAllQuestions(questions: _questions));
    } catch (e) {
      emit(ExamError(error: "Failed to fetch questions: ${e.toString()}"));
    }
  }

  bool _validateQuestionData(Map<String, dynamic> data) {
    return data.containsKey('question_text') &&
        data.containsKey('answer_index') &&
        data.containsKey('options') &&
        data.containsKey('certification_code');
  }

  Future<void> getQuestions(Certification certification) async {
    _certification = certification;
    emit(ExamLoading());
    try {
      await getQuestionsFromFirebase(certification.certificationCode);
    } catch (e) {
      emit(ExamError(error: "Error loading certification questions: ${e.toString()}"));
    }
  }

  void handleTimeOut() {
    _index = certification.numOfQuestions - 1;
    emit(ExamTimeOut());
  }

  void updateIndex() {
    if (_index < _questions.length - 1) {
      _index++;
      emit(ExamQuestionIndexUpdated(questions: _questions));
    } else {
      emit(ExamCompleted(
          score: _score,
          totalQuestions: _questions.length,
          incorrectQuestions: _incorrectQuestionsList
      ));
    }
  }

  void increaseScore() {
    _score++;
    emit(ExamIncreaseScore());
  }

  void addIncorrectQuestion(Question incorrectQuestion) {
    if (!_incorrectQuestionsList.contains(incorrectQuestion)) {
      _incorrectQuestionsList.add(incorrectQuestion);
      emit(ExamAddedIncorrectQuestion(_incorrectQuestionsList));
    }
  }

  void resetExam() {
    _score = 0;
    _index = 0;
    _questions.clear();
    _incorrectQuestionsList.clear();
    isBookmarked = false;
    emit(ExamInitial());
  }

  Future<void> addBookmark(Question question) async {
    try {
      final bookmarkBox = Hive.box('bookmarks');

      final existingBookmark = bookmarkBox.values.firstWhere(
            (bookmark) => bookmark.questionText == question.questionText,
        orElse: () => null,
      );

      if (existingBookmark == null) {
        final newBookmark = Bookmark(
          questionText: question.questionText,
          answer: question.options[question.answerIndex],
        );

        await bookmarkBox.add(newBookmark);
        emit(ExamAddedBookmarkQuestion("Bookmark added successfully."));
      } else {
        emit(ExamAddedBookmarkQuestion("Question is already bookmarked."));
      }
    } catch (e) {
      emit(ExamError(error: "Failed to add bookmark: ${e.toString()}"));
    }
  }

  bool isLastQuestion() {
    return _index >= _questions.length - 1;
  }

/*  Future<void> getQuestionsFromDatabase(String certificationCode) async {
    try {
      final fetchedQuestions = await AppDatabase.instance.getQuestions(certificationCode);
      _questions = fetchedQuestions;
      emit(ExamGetAllQuestions(questions: _questions));
    } catch (e) {
      emit(ExamError(error: "Failed to fetch questions: ${e.toString()}"));
    }
  }*/

/*  Future<void> getQuestions(Certification certification) async {
    _certification = certification;
    emit(ExamLoading());
    try {
      await getQuestionsFromDatabase(certification.certificationCode);
    } catch (e) {
      emit(ExamError(error: "Error loading certification questions: ${e.toString()}"));
    }
  }*/
}