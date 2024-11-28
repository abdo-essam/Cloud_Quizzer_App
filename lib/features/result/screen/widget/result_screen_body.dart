import 'package:cloudquizzer/core/models/certification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/models/questions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/color_manager.dart';
import '../../manager/result_cubit.dart';

class ResultScreenBody extends StatefulWidget {
  const ResultScreenBody({super.key});

  @override
  State<ResultScreenBody> createState() => _ResultScreenBodyState();
}

class _ResultScreenBodyState extends State<ResultScreenBody> {
  int score = 0;
  int endIndex = 0;
  List<Question> incorrectQuestions = [];
  Certification? certification;
  bool scoreSaved = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      score = args['score'] ?? 0;
      endIndex = args['endIndex'] ?? 0;
      incorrectQuestions = List<Question>.from(args['incorrectQuestions'] ?? []);
      certification = args['certification'] as Certification?;
    }

    if (!scoreSaved && certification != null) {
      context.read<ResultCubit>().saveScore(
          score, certification!.certificationName, endIndex + 1);
      scoreSaved = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = endIndex == 0 ? 0 : (score / (endIndex + 1)) * 100;
    final Color progressColor = percentage >= 70 ? ColorManager.green : ColorManager.red;

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: ColorManager.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              _buildResultText(percentage),
              SizedBox(height: 20.h),
              CircularPercentIndicator(
                radius: 85.0,
                lineWidth: 10.0,
                percent: percentage / 100,
                center: Text(
                  "${percentage.toInt()}%",
                  style: _resultTextStyle(ColorManager.white, 18.sp),
                ),
                progressColor: progressColor,
              ),
              SizedBox(height: 20.h),
              _buildCongratulatoryMessage(percentage),
              SizedBox(height: 20.h),
              Text(
                'You have got $score Points',
                style: _resultTextStyle(ColorManager.white, 13.sp),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.popAndPushNamed(context, Routes.homeScreen),
      ),
      backgroundColor: ColorManager.black,
      iconTheme: const IconThemeData(color: ColorManager.white),
      centerTitle: true,
      title: const Text(
        "Result",
        style: TextStyle(
          color: ColorManager.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildResultText(double percentage) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        endIndex != 0
            ? '$score out of ${endIndex + 1} are correct'
            : '$score out of 0 are correct',
        style: _resultTextStyle(ColorManager.white, 18.sp),
      ),
    );
  }

  Widget _buildCongratulatoryMessage(double percentage) {
    final String message = percentage >= 70
        ? 'Congratulations'
        : 'Better luck next time';

    final Color color = percentage >= 70 ? ColorManager.green : ColorManager.red;

    return Text(
      message,
      style: _resultTextStyle(color, 20.sp),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          const Divider(thickness: 1),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(
                label: 'Try Again',
                backgroundColor: Theme.of(context).primaryColor,
                textColor: ColorManager.white,
                onPressed: () {
                  Navigator.popAndPushNamed(context, Routes.examScreen, arguments: {
                    'certification': certification,
                  });
                },
              ),
              SizedBox(width: 10.w),
              _buildButton(
                label: 'Check Answers',
                backgroundColor: ColorManager.white,
                textColor: ColorManager.black,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.reviewQuestionScreen,
                    arguments: {'incorrectQuestions': incorrectQuestions},
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: _resultTextStyle(textColor, 13.sp),
        ),
      ),
    );
  }

  TextStyle _resultTextStyle(Color color, double fontSize) {
    return GoogleFonts.quicksand(
      textStyle: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
