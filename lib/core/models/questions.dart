import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String questionText;
  final int answerIndex;
  final List<String> options;
  final String certificationCode;

  Question({
    required this.questionText,
    required this.answerIndex,
    required this.options,
    required this.certificationCode,
  });

  factory Question.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Question(
      questionText: data['question_text'] ?? '',
      answerIndex: data['answer_index'] ?? 0,
      options: List<String>.from(data['options'] ?? []),
      certificationCode: data['certification_code'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question_text': questionText,
      'answer_index': answerIndex,
      'options': options,
      'certification_code': certificationCode,
    };
  }
}