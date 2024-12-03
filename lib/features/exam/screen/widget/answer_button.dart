import 'package:cloudquizzer/core/models/certification.dart';
import 'package:cloudquizzer/core/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      required this.certification,
      required this.bookmarked});

  final int optionIndex;
  final Question question;
  final Certification certification;
  final bool bookmarked;

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    // this function check if the answer for the first question is correct or not
    ifCorrect() {
      if (widget.question.answerIndex == widget.optionIndex) {
        return ColorManager.green;
      } else {
        return ColorManager.red;
      }
    }

    Color backgroundButtonColor = ifCorrect();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: () {
          // add Bookmark to the list
          if (widget.bookmarked) {
            context.read<ExamCubit>().addBookmark(widget.question);
            Fluttertoast.showToast(
                msg: "Bookmark Added",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.black,
                textColor: ColorManager.white,
                fontSize: 16.0);
            context.read<ExamCubit>().isBookmarked = false;
          }

          // Update button color based on answer correctness
          setState(() {
            if (widget.question.answerIndex == widget.optionIndex) {
              backgroundButtonColor = ColorManager.green; // Correct answer
              context.read<ExamCubit>().increaseScore();
            } else {
              // add Failed Question to the list
              context.read<ExamCubit>().addIncorrectQuestion(widget.question);
              backgroundButtonColor = ColorManager.red; // Incorrect answer
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
            backgroundColor: getColor(ColorManager.cultured, backgroundButtonColor),
            foregroundColor: getColor(ColorManager.black, ColorManager.cultured),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: ColorManager.grayX, width: 0.5),
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
