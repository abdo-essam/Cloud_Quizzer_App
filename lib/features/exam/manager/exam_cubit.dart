import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/local_database/app_database.dart';
import '../../../core/models/certification.dart';
import '../../../core/models/questions.dart';
import 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit() : super(ExamInitial());

  static ExamCubit get(context) => BlocProvider.of<ExamCubit>(context);

  int index = 0;
  int score = 0;
  List<Question> questions = [];
  List<Question> incorrectQuestionsList = [];
  late Certification certification;

  Future<void> getQuestionsFromDatabase(String certificationCode) async {
    questions = await AppDatabase.instance.getQuestions(certificationCode);
    emit(ExamGetAllQuestions(questions: questions));
  }

  Future<void> getQuestions(Certification certification) async {
    this.certification = certification;
    //print('certificationCode: $certificationCode');
    emit(ExamLoading());
    try {
      await getQuestionsFromDatabase(certification.certificationCode);
    } catch (e) {
      emit(ExamError(error: e.toString()));
    }
  }

  updateIndex() async {
    //print('index: $index length: ${questions.length}');
    index++;
    emit(ExamQuestionIndexUpdated(questions: questions));
  }

  increaseScore() {
    score++;
    emit(ExamIncreaseScore());
  }

  void addFailedQuestions(Question incorrectQuestion) {
    incorrectQuestionsList.add(incorrectQuestion);
    emit(ExamAddedFailedQuestion(incorrectQuestionsList));
  }

  void resetExam() {
    score = 0;
    index = 0;
    // Add any other resets needed for the quiz state
    emit(ExamInitial()); // Emit an initial state if you are using states
  }
}
