import 'package:cloudquizzer/core/models/questions.dart';
import 'package:flutter/material.dart';

import 'incorrect_question_item/incorrect_question_item_list_view.dart';

class ReviewQuestionScreenBody extends StatefulWidget {
  const ReviewQuestionScreenBody({super.key});

  @override
  State<ReviewQuestionScreenBody> createState() =>
      _ReviewQuestionScreenBodyState();
}

class _ReviewQuestionScreenBodyState extends State<ReviewQuestionScreenBody> {
  late final List<Question> incorrectQuestions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    incorrectQuestions = args['incorrectQuestions'];
    print("incorrectQuestions: ${incorrectQuestions.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            backgroundColor: Colors.black,
            title: const Text(
              "Incorrect Questions",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: IncorrectQuestionItemListView(
              incorrectQuestions: incorrectQuestions)),
    );
  }
}
