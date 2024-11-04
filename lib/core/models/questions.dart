class Question {
  final int? questionId; // Make it nullable to handle auto-generated IDs
  final String questionText;
  final int answerIndex;
  final List<String> options;

  Question({
    this.questionId,
    required this.questionText,
    required this.answerIndex,
    required this.options,
  });

  // Convert a Question object into a Map object for database insertion.
  Map<String, dynamic> toMap() {
    return {
      'question_text': questionText,
      'answer_index': answerIndex,
      'options': options.join(','),
    };
  }


  // Extract a Question object from a Map (retrieved from the database).
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionId: map['question_id'],
      questionText: map['question_text'],
      answerIndex: map['answer_index'],
      // Convert the stored string back to a list
      options: map['options'].split(','),
    );
  }
}
