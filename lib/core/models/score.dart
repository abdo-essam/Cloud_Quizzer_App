import 'package:hive/hive.dart';

part 'score.g.dart';

@HiveType(typeId: 0)
class Score extends HiveObject {
  @HiveField(0)
  final int score;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String certificationName;

  @HiveField(3)
  final int numOfQuestions;

  Score(
      {required this.score,
      required this.date,
      required this.certificationName,
      required this.numOfQuestions});
}
