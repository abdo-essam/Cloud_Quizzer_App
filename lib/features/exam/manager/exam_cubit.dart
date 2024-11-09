import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/helper/local_database/app_database.dart';
import '../../../core/models/bookmark.dart';
import '../../../core/models/certification.dart';
import '../../../core/models/questions.dart';
import 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit() : super(ExamInitial());

  static ExamCubit get(context) => BlocProvider.of<ExamCubit>(context);

  int index = 0;
  int score = 0;
  bool isBookmarked = false;
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

  void addIncorrectQuestions(Question incorrectQuestion) {
    incorrectQuestionsList.add(incorrectQuestion);
    emit(ExamAddedIncorrectQuestion(incorrectQuestionsList));
  }

  void resetExam() {
    score = 0;
    index = 0;
    // Add any other resets needed for the quiz state
    emit(ExamInitial()); // Emit an initial state if you are using states
  }

  void addBookmark(Question question) async {
    var bookmarkBox = Hive.box('bookmarks');

    // Check if the question is already bookmarked
    final existingBookmark = bookmarkBox.values.firstWhere(
      (bookmark) => bookmark.questionText == question.questionText,
      orElse: () => Bookmark(
        questionText: '',
        answer: '',
      ),
    );

    if (existingBookmark.questionText.isEmpty) {
      // If not bookmarked, add a new bookmark
      final newBookmark = Bookmark(
        questionText: question.questionText,
        answer: question.options[question.answerIndex],
      );

      await bookmarkBox.add(newBookmark);
      isBookmarked = false;
      print('add bookmark');
    } else {
      print("Question already bookmarked.");
    }
  }
}
