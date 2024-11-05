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

class ExamQuestionLastIndexUpdated extends ExamState {}

class ExamIncreaseScore extends ExamState {}

class ExamGetAllQuestions extends ExamState {
  List<Question> questions;

  ExamGetAllQuestions({required this.questions});
}

class ExamChangeOptionButtonColor extends ExamState {}

class ExamAddedFailedQuestion extends ExamState {
  final List<Question> failedQuestions;
  ExamAddedFailedQuestion(this.failedQuestions);
}
