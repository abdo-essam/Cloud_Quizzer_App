

import 'package:flutter/material.dart';

import '../widget/review_question_screen_body.dart';

class ReviewQuestionScreen extends StatelessWidget {
  const ReviewQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: ReviewQuestionScreenBody());
  }
}
