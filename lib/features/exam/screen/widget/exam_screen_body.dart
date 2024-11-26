import 'package:cloudquizzer/core/models/certification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/functions/show_back_alert_dialog.dart';
import '../../../../core/models/questions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/color_manager.dart';
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
  final GlobalKey<CountDownState> _countdownKey = GlobalKey<CountDownState>();
  Certification? certification;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (certification == null) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      certification = args?['certification'];
    }
  }

  /// Navigate to result screen with required arguments
  void _navigateToResult() {
    final examCubit = context.read<ExamCubit>();
    Navigator.of(context).pushNamed(
      Routes.resultScreen,
      arguments: {
        'score': examCubit.score,
        'endIndex': examCubit.index,
        'incorrectQuestions': examCubit.incorrectQuestionsList,
        'certification': certification,
      },
    );
  }

  /// Handles timer timeout scenario
  void _onTimeOut() {
    final examCubit = context.read<ExamCubit>();
    examCubit.handleTimeOut();
    _navigateToResult();
  }

  @override
  Widget build(BuildContext context) {
    final examCubit = context.read<ExamCubit>();
    final currentQuestion = widget.questions[examCubit.index];

    return Scaffold(
      backgroundColor: ColorManager.black,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildHeader(examCubit),
            const SizedBox(height: 20),
            _buildQuestionContent(currentQuestion),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Builds the header section with timer and question number
  Widget _buildHeader(ExamCubit examCubit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CountDown(
            key: _countdownKey,
            quizTime: certification?.examTime ?? 0,
            timeOut: _onTimeOut,
          ),
          Text(
            'Q.${examCubit.index + 1}/${certification?.numOfQuestions ?? 0}',
            style: GoogleFonts.quicksand(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the main question content with options
  Widget _buildQuestionContent(Question question) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              question.questionText,
              style: GoogleFonts.quicksand(
                fontSize: 14.sp,
                color: ColorManager.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            ..._buildAnswerOptions(question),
          ],
        ),
      ),
    );
  }

  /// Builds the answer options
  List<Widget> _buildAnswerOptions(Question question) {
    return List.generate(
      question.options.length,
      (i) => AnswerButton(
        question: question,
        optionIndex: i,
        certification: certification!,
        bookmarked: context.read<ExamCubit>().isBookmarked,
      ),
    );
  }

  /// Builds the bottom navigation bar with buttons
  Widget _buildBottomNavigationBar() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          const Divider(thickness: 1, color: ColorManager.white),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBackButton(),
              const SizedBox(width: 10),
              _buildSubmitButton(),
              const SizedBox(width: 10),
              _buildBookmarkButton(),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the "Back" button
  Widget _buildBackButton() {
    return ElevatedButton(
      style: _buttonStyle(),
      onPressed: () async {
        final shouldNavigateBack = await showBackAlertDialog(
          context,
          'Do you want to exit the exam?',
        );
        if (shouldNavigateBack) {
          Navigator.popAndPushNamed(context, Routes.homeScreen);
        }
      },
      child: Icon(
        Icons.arrow_back_ios_new_sharp,
        size: 15.sp,
        color: ColorManager.white,
      ),
    );
  }

  /// Builds the "Submit" button
  Widget _buildSubmitButton() {
    return Expanded(
      child: ElevatedButton(
        style: _buttonStyle(),
        onPressed: () async {
          final shouldNavigateBack = await showBackAlertDialog(
            context,
            'Do you want to submit the exam?',
          );
          if (shouldNavigateBack) {
            _navigateToResult();
          }
        },
        child: Text(
          'Complete',
          style: GoogleFonts.quicksand(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }

  /// Builds the "Bookmark" button
  Widget _buildBookmarkButton() {
    final examCubit = context.read<ExamCubit>();
    return ElevatedButton(
      style: _buttonStyle(),
      onPressed: () {
        setState(() {
          examCubit.isBookmarked = !examCubit.isBookmarked;
        });
      },
      child: Icon(
        examCubit.isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_border_outlined,
        size: 15.sp,
        color: ColorManager.white,
      ),
    );
  }

  /// Returns a common button style for navigation bar buttons
  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      elevation: 0.0,
      backgroundColor: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 17),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
