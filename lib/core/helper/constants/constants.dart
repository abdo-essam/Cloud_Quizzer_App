import 'package:cloudquizzer/core/models/certification.dart';

class Constants {
  static List<Certification> certificationsData = [
    Certification(
      certificationName: 'AWS Certified Cloud Practitioner',
      numOfQuestions: 65,
      examTime: 90,
      imagePath: 'assets/images/aws_cloud_practitioner_badge.png',
      cloudProvider: 'AWS',
      certificationCode:'AWS-CCP'
    ),
/*    Certification(
      certificationName: 'AWS Certified Solutions Architect - Associate',
      numOfQuestions: 65,
      examTime: 130,
      imagePath: 'assets/images/aws_cloud_practitioner_badge.png',
      cloudProvider: 'AWS',
      certificationCode: 'AWS-SAA'
    ),*/
    Certification(
      certificationName: 'Microsoft Certified: Azure Fundamentals',
      numOfQuestions: 40,
      examTime: 85,
      imagePath: 'assets/images/azure_fundamentals_badge.png',
      cloudProvider: 'Microsoft Azure',
      certificationCode: 'AZ-900'
    ),
/*    Certification(
      certificationName: 'Microsoft Certified: Azure Administrator Associate',
      numOfQuestions: 60,
      examTime: 120,
      imagePath: 'assets/images/aws_cloud_practitioner_badge.png',
      cloudProvider: 'Microsoft Azure',
      certificationCode: 'AZ-104'
    ),*/
    Certification(
      certificationName: 'Google Associate Cloud Engineer',
      numOfQuestions: 50,
      examTime: 120,
      imagePath: 'assets/images/google_associate_cloud_engineer_badge.png',
      cloudProvider: 'Google Cloud',
      certificationCode: 'GCP-ACE'
    ),
/*    Certification(
      certificationName: 'Google Professional Cloud Architect',
      numOfQuestions: 50,
      examTime: 120,
      imagePath: 'assets/images/aws_cloud_practitioner_badge.png',
      cloudProvider: 'Google Cloud',
      certificationCode: 'GCP-PCA'
    ),*/
  ];
}
