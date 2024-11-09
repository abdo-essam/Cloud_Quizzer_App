import 'package:cloudquizzer/core/models/certification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/models/questions.dart';
import '../../../../core/routes/routes.dart';
import '../../manager/result_cubit.dart';

class ResultScreenBody extends StatefulWidget {
  const ResultScreenBody({super.key});

  @override
  State<ResultScreenBody> createState() => _ResultScreenBodyState();
}

class _ResultScreenBodyState extends State<ResultScreenBody> {
  int score = 0; // Initialize with default values
  int endIndex = 0;
  List<Question> incorrectQuestions = [];
  Certification? certification; // Make certification nullable

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    // Handle null and type check for arguments
    if (args is Map<String, dynamic>) {
      score = args['score'] ?? 0; // Use ?? to provide default value
      endIndex = args['endIndex'] ?? 0;
      incorrectQuestions =
          List<Question>.from(args['incorrectQuestions'] ?? []);
      certification = args['certification'] as Certification?;
    } else {
      // Handle invalidarguments, e.g., show an error message
      print('Invalid arguments passed to ResultScreenBody');
    }

    // Save score if certification is not null
    if (certification != null) {
      context.read<ResultCubit>().saveScore(score,
          certification!.certificationName, certification!.numOfQuestions);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;
    double percentage = endIndex == 0 ? 0 : (score / (endIndex + 1)) * 100;
    // print('percentage: $percentage score: $score endIndex: $endIndex');
    if (percentage >= 70) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text(
            "Result",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.black,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  endIndex != 0
                      ? '$score out of ${endIndex + 1} are correct'
                      : '$score out of 0 are correct',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              CircularPercentIndicator(
                radius: 85.0,
                lineWidth: 10.0,
                percent: percentage / 100,
                center: Text(
                  "${percentage.toInt()}%",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
                progressColor: color,
              ),
              SizedBox(
                height: 20.h,
              ),
              if (percentage >= 70)
                Text(
                  'Congratulations',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: color,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              if (percentage < 70)
                Text(
                  'Better luck next time',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'You have got $score Points',
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
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
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed(
                          Routes.examScreen,
                          arguments: {
                            'certification': certification,
                          },
                        );
                      },
                      child: Text(
                        'Try Again',
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.reviewQuestionScreen, arguments: {
                          'incorrectQuestions': incorrectQuestions
                        });
                      },
                      child: Text(
                        'Check Answers',
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
