import 'package:cloudquizzer/core/models/questions.dart';
import 'package:cloudquizzer/features/review/screen/widget/incorrect_question_item/incorrect_question_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncorrectQuestionItemListView extends StatelessWidget {
  const IncorrectQuestionItemListView(
      {super.key, required this.incorrectQuestions});

  final List<Question> incorrectQuestions;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: 530.h,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ListView.builder(
              itemBuilder: (context, index) {
                return IncorrectQuestionItem(
                    incorrectQuestion: incorrectQuestions[index]);
              },
              itemCount: incorrectQuestions.length),
        ),
      ),
    );
  }
}
