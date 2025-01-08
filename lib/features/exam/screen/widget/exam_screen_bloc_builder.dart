import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/functions/show_back_alert_dialog.dart';
import '../../../../core/models/questions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/color_manager.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/no_data_founded_screen.dart';
import '../../manager/exam_cubit.dart';
import '../../manager/exam_state.dart';
import 'exam_screen_body.dart';

class ExamScreenBlocBuilder extends StatelessWidget {
  const ExamScreenBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamCubit, ExamState>(
      builder: (context, state) => _buildStateScreen(context, state),
      listener: (context, state) => _handleStateListener(context, state),
    );
  }

  Widget _buildStateScreen(BuildContext context, ExamState state) {
    final questions = context.read<ExamCubit>().questions;
    if (state is ExamLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: ColorManager.primaryColor,
        ),
      );
    } else if (state is ExamGetAllQuestions) {
      return _buildQuestionScreen(state.questions);
    } else if (state is ExamQuestionIndexUpdated) {
      return _buildQuestionScreen(state.questions);
    } else if (state is ExamAddedIncorrectQuestion) {
      return _buildQuestionScreen(context.read<ExamCubit>().questions);
    } else if (state is ExamCompleted) {
      // Handle quiz completion
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToResults(context, state);
      });
      return _buildQuestionScreen(questions);
    } else if (state is ExamError) {
      return ErrorDialog(
        error: state.error,
        onRetry: () {
          context.read<ExamCubit>().getQuestions(
              context.read<ExamCubit>().certification);
        },
      );
    }

    return _buildQuestionScreen(questions);
  }

  void _navigateToResults(BuildContext context, ExamCompleted state) {
    Navigator.of(context).pushReplacementNamed(
      Routes.resultScreen,
      arguments: {
        'score': state.score,
        'endIndex': state.totalQuestions - 1,
        'incorrectQuestions': state.incorrectQuestions,
        'certification': context.read<ExamCubit>().certification,
      },
    );
  }

  void _handleStateListener(BuildContext context, ExamState state) {
    if (state is ExamError) {
      showBackAlertDialog(context, state.error);
    } else if (state is ExamAddedBookmarkQuestion) {
      Fluttertoast.showToast(
        msg: "Bookmark Added Successfully",
        backgroundColor: ColorManager.black,
        textColor: ColorManager.white,
      );
    }
  }

  Widget _buildQuestionScreen(List<Question> questions) {
    if (questions.isEmpty) {
      return const NoDataFoundedScreen();
    }
    return ExamScreenBody(questions: questions);
  }
}