import 'package:cloudquizzer/core/models/questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/color_manager.dart';

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
            color: ColorManager.cultured,
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
                      color: ColorManager.red,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    flex: 20,
                    child: Text(
                      widget.incorrectQuestion.questionText,
                      style: const TextStyle(fontSize: 18, color: ColorManager.black),
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
                    const Text("Correct Answer : ",
                        style: TextStyle(
                            color: ColorManager.green, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                          widget.incorrectQuestion
                              .options[widget.incorrectQuestion.answerIndex].substring(3),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ]),
            ],
          )),
    );
  }
}
