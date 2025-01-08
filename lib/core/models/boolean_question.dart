// lib/core/models/boolean_question.dart
class BooleanQuestion {
  final String questionText;
  final bool answer;

  BooleanQuestion({
    required this.questionText,
    required this.answer,
  });

  factory BooleanQuestion.fromFirestore(Map<String, dynamic> data) {
    return BooleanQuestion(
      questionText: data['question_text'],
      answer: data['answer'],
    );
  }
}

// lib/core/models/mcq_question.dart
class MCQQuestion {
  final String questionText;
  final int answerIndex;
  final List<String> options;

  MCQQuestion({
    required this.questionText,
    required this.answerIndex,
    required this.options,
  });

  factory MCQQuestion.fromFirestore(Map<String, dynamic> data) {
    return MCQQuestion(
      questionText: data['question_text'],
      answerIndex: data['answer_index'],
      options: List<String>.from(data['options']),
    );
  }
}

// lib/core/models/mcq_multiple_question.dart
class MCQMultipleQuestion {
  final String questionText;
  final List<int> correctAnswers;
  final List<String> options;

  MCQMultipleQuestion({
    required this.questionText,
    required this.correctAnswers,
    required this.options,
  });

  factory MCQMultipleQuestion.fromFirestore(Map<String, dynamic> data) {
    return MCQMultipleQuestion(
      questionText: data['question_text'],
      correctAnswers: List<int>.from(data['correct_answers']),
      options: List<String>.from(data['options']),
    );
  }
}