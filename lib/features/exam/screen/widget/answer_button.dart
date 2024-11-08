import 'package:cloudquizzer/core/models/certification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/functions/get_color.dart';
import '../../../../core/models/questions.dart';
import '../../../../core/routes/routes.dart';
import '../../manager/exam_cubit.dart';

class AnswerButton extends StatefulWidget {
  const AnswerButton(
      {super.key,
      required this.question,
      required this.optionIndex,
      required this.certification});

  final int optionIndex;
  final Question question;
  final Certification certification;

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    // this function check if the answer for the first question is correct or not
    ifCorrect() {
      if (widget.question.answerIndex == widget.optionIndex) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }

    Color backgroundButtonColor = ifCorrect();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: () {
          // Update button color based on answer correctness
          setState(() {
            if (widget.question.answerIndex == widget.optionIndex) {
              backgroundButtonColor = Colors.green; // Correct answer
              context.read<ExamCubit>().increaseScore();
            } else {
              // add Failed Question to the list
              context.read<ExamCubit>().addFailedQuestions(widget.question);
              print(context.read<ExamCubit>().incorrectQuestionsList.length);
              backgroundButtonColor = Colors.red; // Incorrect answer
            }
          });

          // if it is the last question then navigate to the result screen
          if (context.read<ExamCubit>().index ==
              widget.certification.numOfQuestions - 1) {
            Navigator.of(context).pushNamed(Routes.resultScreen, arguments: {
              'score': context.read<ExamCubit>().score,
              'endIndex': context.read<ExamCubit>().index,
              'incorrectQuestions':
                  context.read<ExamCubit>().incorrectQuestionsList,
              'certification': widget.certification
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
            backgroundColor: getColor(Colors.white, backgroundButtonColor),
            foregroundColor: getColor(Colors.black, Colors.white),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Colors.grey, width: 0.5),
            ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // expand the text to fill the whole width if option text is too long
            Expanded(
              child: Text(
                // select the option by index in the for loop
                widget.question.options[widget.optionIndex],
                style: GoogleFonts.quicksand(
                  fontSize: 12.sp,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward, size: 16.0),
          ],
        ),
      ),
    );
  }
}
