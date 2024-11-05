import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../manager/exam_cubit.dart';
import 'count_down.dart';

/*class ExamScreenTobBar extends StatelessWidget {
  const ExamScreenTobBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CountDown(
            quizTime: 1,
            timeOut: () {
              // if time out then the reminder questions will be incorrect
              // then make the index equal to the last question to calculating the score for overall

              if (context
                  .read<ExamCubit>()
                  .index != 0) {
                context.read<ExamCubit>().index = widget.questions.length - 1;
              }
              navToResult();
            },
          ),
          Text(
            'Q.${context
                .read<ExamCubit>()
                .index + 1}/${widget.questions.length}',
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    )
  }
}*/
