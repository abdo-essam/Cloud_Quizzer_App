import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/functions/get_color.dart';
import '../../../../core/models/questions.dart';
import '../../../../core/routes/routes.dart';
import '../../manager/exam_cubit.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(
      {super.key, required this.question, required this.optionIndex});

  final int optionIndex;
  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: () {
/*
          if (question.answerIndex == optionIndex) {
            context.read<ExamCubit>().changeOptionButtonColor(Colors.green);
          } else {
            context.read<ExamCubit>().changeOptionButtonColor(Colors.red);
          }
*/

          // check if the answer is correct
          if (question.answerIndex == optionIndex) {
            context.read<ExamCubit>().increaseScore();
          }

          // check if it is the last question
          if (context.read<ExamCubit>().index ==
              context.read<ExamCubit>().questions.length - 1) {
            Navigator.of(context)
                .popAndPushNamed(Routes.resultScreen, arguments: {
              'score': context.read<ExamCubit>().score,
              'endIndex': context.read<ExamCubit>().index,
            });
          } else {
            // go to next question
            context.read<ExamCubit>().updateIndex();
          }
        },
        style: ButtonStyle(
            elevation: const WidgetStatePropertyAll(0),
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 25, horizontal: 15)),
            backgroundColor: getColor(Colors.white, Colors.deepOrange),
            foregroundColor: getColor(Colors.black, Colors.white),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Colors.grey, width: 0.5),
            ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              // select the option by index in the for loop
              question.options[optionIndex],
              style: GoogleFonts.quicksand(
                fontSize: 12.sp,
              ),
            ),
            const Icon(Icons.arrow_forward, size: 16.0),
          ],
        ),
      ),
    );
  }
}
