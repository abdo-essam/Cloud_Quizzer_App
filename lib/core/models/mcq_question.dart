// lib/core/models/mcq_question.dart
import 'package:cloudquizzer/core/models/questions.dart';

class MCQQuestion extends Question {
  MCQQuestion({
    required super.questionText,
    required super.answerIndex,
    required super.options,
    required super.certificationCode,
  });

  factory MCQQuestion.fromFirestore(Map<String, dynamic> data) {
    return MCQQuestion(
      questionText: data['question_text'] ?? '',
      answerIndex: data['answer_index'] ?? 0,
      options: List<String>.from(data['options'] ?? []),
      certificationCode: data['certification_code'] ?? '',
    );
  }
}