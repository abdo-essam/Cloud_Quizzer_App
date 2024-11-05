import 'package:cloudquizzer/core/models/certification.dart';

class Constants {
  static List<Certification> certificationsData = [
    Certification(
      certificationName: 'AWS Certified Cloud Practitioner',
      numOfQuestions: 65,
      examTime: 90,
      imagePath: 'assets/images/aws_cloud_practitioner_badge.png',
      cloudProvider: 'AWS',
    ),
/*    Certification(
      certificationName: 'AWS Certified Solutions Architect - Associate',
      numOfQuestions: 65,
      examTime: 130,
      imagePath: 'assets/images/aws_solutions_architect_associate_badge.png',
      cloudProvider: 'AWS',
    ),*/
    Certification(
      certificationName: 'Microsoft Certified: Azure Fundamentals',
      numOfQuestions: 40,
      examTime: 85,
      imagePath: 'assets/images/azure_fundamentals_badge.png',
      cloudProvider: 'Microsoft Azure',
    ),
/*    Certification(
      certificationName: 'Microsoft Certified: Azure Administrator Associate',
      numOfQuestions: 60,
      examTime: 120,
      imagePath: 'assets/images/azure_administrator_badge.png',
      cloudProvider: 'Microsoft Azure',
    ),*/
    Certification(
      certificationName: 'Google Associate Cloud Engineer',
      numOfQuestions: 50,
      examTime: 120,
      imagePath: 'assets/images/google_associate_cloud_engineer_badge.png',
      cloudProvider: 'Google Cloud',
    ),
/*    Certification(
      certificationName: 'Google Professional Cloud Architect',
      numOfQuestions: 50,
      examTime: 120,
      imagePath: 'assets/images/google_professional_cloud_architect_badge.png',
      cloudProvider: 'Google Cloud',
    ),*/
  ];
}
