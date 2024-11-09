import 'package:cloudquizzer/core/models/certification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/functions/show_back_alert_dialog.dart';
import '../../../../core/models/questions.dart';
import '../../../../core/routes/routes.dart';
import '../../manager/exam_cubit.dart';
import 'answer_button.dart';
import 'count_down.dart';

class ExamScreenBody extends StatefulWidget {
  const ExamScreenBody({super.key, required this.questions});

  final List<Question> questions;

  @override
  State<ExamScreenBody> createState() => _ExamScreenBodyState();
}

class _ExamScreenBodyState extends State<ExamScreenBody> {
  //bool isBookmarked = false;

  //  Manages the CountDown state, letting it persist across question updates.
  final GlobalKey<CountDownState> _countdownKey = GlobalKey<CountDownState>();

  Certification? certification;

  @override
  // add certification data using didChangeDependencies method to avoid rebuilds
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    certification = args['certification'];

    //print(incorrectQuestions[0].questionText);
  }

  void navToResult() {
    Navigator.of(context).popAndPushNamed(
      Routes.resultScreen,
      arguments: {
        'score': context.read<ExamCubit>().score,
        'endIndex': context.read<ExamCubit>().index,
        'incorrectQuestions': context.read<ExamCubit>().incorrectQuestionsList,
        'certification': certification,
      },
    );
  }

  void restartCountdown() {
    _countdownKey.currentState?.restart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CountDown(
                    key: _countdownKey,
                    quizTime: certification!.examTime,
                    timeOut: () {
                      // if time out then the reminder questions will be incorrect
                      // then make the index equal to the last question to calculating the score for overall

                      if (context.read<ExamCubit>().index != 0) {
                        context.read<ExamCubit>().index =
                            widget.questions.length - 1;
                      }
                      navToResult();
                    },
                  ),
                  // Text to display the question number
                  Text(
                    'Q.${context.read<ExamCubit>().index + 1}/${certification!.numOfQuestions}',
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
            ),
            SizedBox(
              height: 20.h,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),

                  Text(
                    widget.questions[context.read<ExamCubit>().index]
                        .questionText,
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  // for loop to display the options
                  for (int i = 0;
                      i <
                          widget.questions[context.read<ExamCubit>().index]
                              .options.length;
                      i++)
                    AnswerButton(
                        question:
                            widget.questions[context.read<ExamCubit>().index],
                        optionIndex: i,
                        certification: certification!,
                        bookmarked: context.read<ExamCubit>().isBookmarked),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 19),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () async {
                    bool shouldNavigateBack = await showBackAlertDialog(
                        context, 'Do you want to Exit the Exam?');
                    if (shouldNavigateBack) {
                      Navigator.popAndPushNamed(context, Routes.homeScreen);
                    }
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    size: 15.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () async {
                    bool shouldNavigateBack = await showBackAlertDialog(
                        context, 'Do you want to submit the exam ?');
                    if (shouldNavigateBack) {
                      navToResult();
                    }
                  },
                  child: Text(
                    'Complete',
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )),
                SizedBox(
                  width: 10.w,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 19),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      context.read<ExamCubit>().isBookmarked = !context.read<ExamCubit>().isBookmarked;
                    });
                  },
                  child: Icon(
                    context.read<ExamCubit>().isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border_outlined,
                    size: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
