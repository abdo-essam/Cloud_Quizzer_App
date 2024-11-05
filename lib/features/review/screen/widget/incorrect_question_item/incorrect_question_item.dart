import 'package:cloudquizzer/core/models/questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncorrectQuestionItem extends StatefulWidget {
  const IncorrectQuestionItem({super.key, required this.incorrectQuestion});

  final Question incorrectQuestion;

  @override
  State<IncorrectQuestionItem> createState() => _IncorrectQuestionItemState();
}

class _IncorrectQuestionItemState extends State<IncorrectQuestionItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  const Expanded(
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    flex: 20,
                    child: Text(
                      widget.incorrectQuestion.questionText,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Correct: ",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    Text(
                        widget.incorrectQuestion
                            .options[widget.incorrectQuestion.answerIndex],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ]),
            ],
          )),
    );
  }
}
