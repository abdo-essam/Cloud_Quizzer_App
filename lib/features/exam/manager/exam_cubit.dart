import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/local_database/app_database.dart';
import '../../../core/models/questions.dart';
import 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit() : super(ExamInitial());

  static ExamCubit get(context) => BlocProvider.of<ExamCubit>(context);
  int index = 0;
  int score = 0;
  Color optionButtonColor = Colors.red;
  List<Question> questions = [];
  List<Question> incorrectQuestionsList = [];

  Future<void> getQuestionsFromDatabase() async {
    questions = await AppDatabase.instance.getQuestions();
    emit(ExamGetAllQuestions(questions: questions));
  }

  Future<void> getQuestions() async {
    emit(ExamLoading());
    try {
      await getQuestionsFromDatabase();
    } catch (e) {
      emit(ExamError(error: e.toString()));
    }
  }

  updateIndex() async {
    print('index: $index length: ${questions.length}');
    index++;
    emit(ExamQuestionIndexUpdated(questions: questions));
  }

  changeOptionButtonColor(Color color) {
    optionButtonColor = color;
    emit(ExamChangeOptionButtonColor());
  }

  increaseScore() {
    score++;
    emit(ExamIncreaseScore());
  }

  void addFailedQuestions(Question incorrectQuestion) {
    incorrectQuestionsList.add(incorrectQuestion);
    emit(ExamAddedFailedQuestion(incorrectQuestionsList));
  }
}
