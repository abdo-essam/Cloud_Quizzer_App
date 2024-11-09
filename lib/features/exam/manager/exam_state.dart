import '../../../core/models/questions.dart';

abstract class ExamState {}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamError extends ExamState {
  final String error;

  ExamError({required this.error});
}

class ExamQuestionIndexUpdated extends ExamState {
  List<Question> questions;

  ExamQuestionIndexUpdated({required this.questions});
}

class ExamIncreaseScore extends ExamState {}

class ExamGetAllQuestions extends ExamState {
  List<Question> questions;

  ExamGetAllQuestions({required this.questions});
}

class ExamGetCertificationQuestions extends ExamState {
  List<Question> questions;

  ExamGetCertificationQuestions({required this.questions});
}

class ExamChangeOptionButtonColor extends ExamState {}

class ExamAddedIncorrectQuestion extends ExamState {
  final List<Question> incorrectQuestions;

  ExamAddedIncorrectQuestion(this.incorrectQuestions);
}

class ExamAddedBookmarkQuestion extends ExamState {
  final String message;
  ExamAddedBookmarkQuestion(this.message);
}
