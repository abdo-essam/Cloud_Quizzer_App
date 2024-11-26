import 'package:cloudquizzer/core/widgets/error_screen.dart';
import 'package:cloudquizzer/features/home/screen/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/show_back_alert_dialog.dart';
import '../../../../core/models/questions.dart';
import '../../../../core/theme/color_manager.dart';
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

  /// Builds the appropriate screen based on the current state.
  Widget _buildStateScreen(BuildContext context, ExamState state) {
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
    } else if (state is ExamError) {
      return const ErrorScreen();
    }

    // Default fallback screen to handle unexpected states gracefully
    return const HomeScreen();
  }

  /// Handles side effects when the state changes.
  void _handleStateListener(BuildContext context, ExamState state) {
    if (state is ExamError) {
      showBackAlertDialog(context, state.error);
    } else if (state is ExamAddedBookmarkQuestion) {
      debugPrint('Question bookmarked successfully!');
    }
  }

  /// Renders the question screen or a "no data" screen if the question list is empty.
  Widget _buildQuestionScreen(List<Question> questions) {
    if (questions.isEmpty) {
      return const NoDataFoundedScreen();
    }
    return ExamScreenBody(questions: questions);
  }
}
