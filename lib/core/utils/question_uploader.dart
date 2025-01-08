// lib/utils/question_uploader.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionUploader {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<void> uploadMultiChoiceQuestions() async {
    const certificationCode = 'AWS-CCP';

    final mcq_m_questions = [
      // Add more multi-choice questions
    ];

    try {
      final batch = _firestore.batch();
      final collectionRef = _firestore
          .collection('categories')
          .doc('cloud')
          .collection(certificationCode)
          .doc('questions')
          .collection('mcq_m');

      int index = 1;
      for (var questionData in mcq_m_questions) {
        final docRef = collectionRef.doc('$index');
        batch.set(docRef, questionData);
        index++; // Increment the sequence
      }

      await batch.commit();
      print('Successfully uploaded multi-choice questions');
    } catch (e) {
      print('Error uploading questions: $e');
    }
  }

  static Future<void> uploadAWSQuestions() async {
    const certificationCode = 'AWS-CCP';
    final mcq_questions = [
      // Add more questions here
    ];
    try {
      final batch = _firestore.batch();
      final collectionRef = _firestore
          .collection('categories')
          .doc('cloud')
          .collection(certificationCode)
          .doc('questions')
          .collection('mcq');

      int index = 182;
      for (var questionData in mcq_questions) {
        final docRef = collectionRef.doc('$index');
        batch.set(docRef, questionData);
        index++; // Increment the sequence
      }

      await batch.commit();
      print('Successfully uploaded AWS questions');
    } catch (e) {
      print('Error uploading questions: $e');
    }
  }

  static Future<void> uploadAzureQuestions() async {
    const certificationCode = 'AZ-900';

    final questions = [
      {
        'question_text': 'What is Azure Virtual Network?',
        'answer_index': 0,
        'options': [
          'A network isolation service',
          'A storage service',
          'A compute service',
          'A database service'
        ],
      },
      // Add more Azure questions
    ];

    // Upload logic similar to AWS questions
  }

  static Future<void> uploadGCPQuestions() async {
    const certificationCode = 'GCP-ACE';

    final questions = [
      {
        'question_text': 'What is Google Cloud Storage?',
        'answer_index': 1,
        'options': [
          'Compute service',
          'Object storage service',
          'Database service',
          'Networking service'
        ],
      },
      // Add more GCP questions
    ];

    // Upload logic similar to AWS questions
  }

  // questions_data.dart
  static const awsQuestions = [
    {
      'question_text': 'Question 1...',
      'answer_index': 0,
      'options': ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    },
    // Add more questions
  ];

/*  static const azureQuestions = [
    // Azure questions
  ];

  static const gcpQuestions = [
    // GCP questions
  ];*/

  static Future<void> uploadAllQuestions() async {
    await uploadQuestionsForCertification('AWS-CCP', awsQuestions);
    //await uploadQuestionsForCertification('AZ-900', azureQuestions);
   // await uploadQuestionsForCertification('GCP-ACE', gcpQuestions);
  }

  static Future<void> uploadQuestionsForCertification(
      String certificationCode,
      List<Map<String, dynamic>> questions
      ) async {
    try {
      final batch = _firestore.batch();
      final collectionRef = _firestore
          .collection('categories')
          .doc('cloud')
          .collection(certificationCode)
          .doc('questions')
          .collection('mcq');

      for (var questionData in questions) {
        final docRef = collectionRef.doc();
        batch.set(docRef, questionData);
      }

      await batch.commit();
      print('Successfully uploaded $certificationCode questions');
    } catch (e) {
      print('Error uploading $certificationCode questions: $e');
    }
  }
}