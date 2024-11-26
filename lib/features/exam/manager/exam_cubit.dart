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

  int _index = 0;
  int _score = 0;
  bool isBookmarked = false;

  List<Question> _questions = [];
  final List<Question> _incorrectQuestionsList = [];
  late Certification _certification;

  /// Getter for public access to private fields
  int get index => _index;

  int get score => _score;

  List<Question> get questions => List.unmodifiable(_questions);

  List<Question> get incorrectQuestionsList =>
      List.unmodifiable(_incorrectQuestionsList);

  Certification get certification => _certification;

  /// Fetches questions from the database for a specific certification code.
  Future<void> getQuestionsFromDatabase(String certificationCode) async {
    try {
      final fetchedQuestions =
          await AppDatabase.instance.getQuestions(certificationCode);
      _questions = fetchedQuestions;
      emit(ExamGetAllQuestions(questions: _questions));
    } catch (e) {
      emit(ExamError(error: "Failed to fetch questions: ${e.toString()}"));
    }
  }

  /// Initializes the exam by loading questions for the given certification.
  Future<void> getQuestions(Certification certification) async {
    _certification = certification;
    emit(ExamLoading());
    try {
      await getQuestionsFromDatabase(certification.certificationCode);
    } catch (e) {
      emit(ExamError(
          error: "Error loading certification questions: ${e.toString()}"));
    }
  }

  void handleTimeOut() {
    // Ensure the index is set to the last question if timeout occurs
    _index = certification.numOfQuestions - 1;
  }

  /// Advances to the next question and updates the state.
  void updateIndex() {
    if (_index < _questions.length - 1) {
      _index++;
      emit(ExamQuestionIndexUpdated(questions: _questions));
    } else {
      emit(ExamError(error: "No more questions available."));
    }
  }

  /// Increases the user's score and emits the updated state.
  void increaseScore() {
    _score++;
    emit(ExamIncreaseScore());
  }

  /// Adds an incorrectly answered question to the list and emits the updated state.
  void addIncorrectQuestion(Question incorrectQuestion) {
    _incorrectQuestionsList.add(incorrectQuestion);
    emit(
        ExamAddedIncorrectQuestion(List.unmodifiable(_incorrectQuestionsList)));
  }

  /// Resets the exam state to its initial values.
  void resetExam() {
    _score = 0;
    _index = 0;
    _questions.clear();
    _incorrectQuestionsList.clear();
    emit(ExamInitial());
  }

  /// Adds a bookmark for a specific question.
  Future<void> addBookmark(Question question) async {
    try {
      final bookmarkBox = Hive.box('bookmarks');

      // Check if the question is already bookmarked
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
}
