class Certification {
  // Make it nullable to handle auto-generated IDs
  final String certificationName;
  final int numOfQuestions;
  final int examTime;
  final String imagePath;
  final String cloudProvider;
  final String certificationCode;

  Certification(
      {required this.certificationName,
      required this.numOfQuestions,
      required this.examTime,
      required this.imagePath,
      required this.cloudProvider,
      required this.certificationCode});
}
