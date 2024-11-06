import 'package:cloudquizzer/core/widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/show_back_alert_dialog.dart';
import '../../../../core/models/questions.dart';
import '../../../../core/widgets/no_data_founded_screen.dart';
import '../../manager/exam_cubit.dart';
import '../../manager/exam_state.dart';
import 'exam_screen_body.dart';

class ExamScreenBlocBuilder extends StatelessWidget {
  const ExamScreenBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamCubit, ExamState>(
      builder: (context, state) {
        if (state is ExamLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          );
        }
        if (state is ExamGetAllQuestions) {
          return getQuestionScreen(state.questions);
        }

        if (state is ExamQuestionIndexUpdated) {
          return getQuestionScreen(state.questions);
        }

        return const ErrorScreen();

      },
      listener: (BuildContext context, ExamState state) {
        if (state is ExamError) {
          showBackAlertDialog(context, state.error);
        }
      },
    );
  }

  Widget getQuestionScreen(List<Question> questions) {
    if (questions.isEmpty) {
      return const NoDataFoundedScreen();
    }
    return ExamScreenBody(questions: questions);
  }
}
