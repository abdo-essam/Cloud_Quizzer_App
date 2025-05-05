import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/boolean_question.dart';
import '../models/questions.dart';

class FirebaseService {
  Future<void> testFirestoreConnection(String certificationCode) async {
    try {
      final docRef = _firestore
          .collection('categories')
          .doc('cloud')
          .collection(certificationCode)
          .doc('questions');

      final doc = await docRef.get();
      print('Connection test - Document exists: ${doc.exists}');
      if (doc.exists) {
        print('Document data: ${doc.data()}');
      }
    } catch (e) {
      print('Firestore connection test failed: $e');
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Add error handling wrapper
  Future<T> _handleFirestoreOperation<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on FirebaseException catch (e) {
      print('Firebase Error: ${e.code} - ${e.message}');
      throw 'Database error: ${e.message}';
    } catch (e) {
      print('General Error: $e');
      throw 'An unexpected error occurred';
    }
  }

  Future<List<Question>> getQuestions(String certificationCode) async {
    try {
      final questions = <Question>[];

      final mcqSnapshot = await _firestore
          .collection('categories')
          .doc('cloud')
          .collection(certificationCode)
          .doc('questions')
          .collection('mcq')
          .get();

      print('Found ${mcqSnapshot.docs.length} MCQ questions');

      for (var doc in mcqSnapshot.docs) {
        try {
          print('Processing document ${doc.id}');
          final data = doc.data();
          // Add certification code to the data
          data['certification_code'] = certificationCode;
          print('Document data: $data');

          if (!_validateMCQData(data)) {
            print('Invalid question data in document ${doc.id}');
            continue;
          }

          final question = Question.fromFirestore(data as DocumentSnapshot<Object?>);
          questions.add(question);
          print('Successfully added question: $question');
        } catch (e) {
          print('Error processing document ${doc.id}: $e');
          continue;
        }
      }

      print('Final questions list: $questions');
      return questions;
    } catch (e) {
      print('Error in getQuestions: $e');
      throw 'Failed to fetch questions: $e';
    }
  }

  bool _validateMCQData(Map<String, dynamic> data) {
    return data.containsKey('question_text') &&
        data.containsKey('answer_index') &&
        data.containsKey('options') &&
        data.containsKey('certification_code');
  }
 /* Future<List<Question>> getQuestions(String certificationCode) async {
    try {
      final questions = <Question>[];

*//*      // Fetch boolean questions
      final booleanSnapshot = await _firestore
          .collection('categories')
          .doc('cloud')
          .collection(certificationCode)
          .doc('questions')
          .collection('boolean')
          .get();

      for (var doc in booleanSnapshot.docs) {
        questions.add(BooleanQuestion.fromFirestore(doc.data()));
      }*//*

      // Fetch MCQ questions
      final mcqSnapshot = await _firestore
          .collection('categories')
          .doc('cloud')
          .collection(certificationCode)
          .doc('questions')
          .collection('mcq')
          .get();

      print('Found ${mcqSnapshot.docs.length} MCQ questions');

      for (var doc in mcqSnapshot.docs) {
        try {
          // Print raw document data
          print('Processing document ${doc.id}');
          final data = doc.data();
          print('Document data: $data}');

          final questionData = doc.data();
          // Validate required fields
          if (!_validateMCQData(questionData)) {
            print('Invalid question data in document ${doc.id}');
            continue;
          }

          final question = MCQQuestion.fromFirestore(questionData);
          questions.add(question);
          print('Successfully added question: $question');
        } catch (e) {
          print('Error processing document ${doc.id}: $e');
          continue;
        }
      }

      print('Final questions list: $questions');
      return questions;
    } catch (e) {
      print('Error in getQuestions: $e');
      throw 'Failed to fetch questions: $e';
    }
  }*/

  // Helper method to print document structure
  void _debugPrintDocument(DocumentSnapshot doc) {
    print('Document ID: ${doc.id}');
    print('Document exists: ${doc.exists}');
    print('Document data: ${doc.data()}');
    print('Document metadata: ${doc.metadata}');
  }

/*      // Fetch MCQ multiple questions
      final mcqMultipleSnapshot = await _firestore
          .collection('categories')
          .doc('cloud')
          .collection(certificationCode)
          .doc('questions')
          .collection('mcq_m')
          .get();

      for (var doc in mcqMultipleSnapshot.docs) {
        questions.add(MCQMultipleQuestion.fromFirestore(doc.data()));
      }*/

  // Add question helper methods
  Future<void> addBooleanQuestion(String certificationCode, BooleanQuestion question) async {
    await _firestore
        .collection('categories')
        .doc('cloud')
        .collection(certificationCode)
        .doc('questions')
        .collection('boolean')
        .add({
      'question_text': question.questionText,
      'answer': question.answer,
    });
  }

  Future<void> addMCQQuestion(String certificationCode, MCQQuestion question) async {
    await _firestore
        .collection('categories')
        .doc('cloud')
        .collection(certificationCode)
        .doc('questions')
        .collection('mcq')
        .add({
      'question_text': question.questionText,
      'answer_index': question.answerIndex,
      'options': question.options,
    });
  }

  Future<void> addMCQMultipleQuestion(
      String certificationCode, MCQMultipleQuestion question) async {
    await _firestore
        .collection('categories')
        .doc('cloud')
        .collection(certificationCode)
        .doc('questions')
        .collection('mcq_m')
        .add({
      'question_text': question.questionText,
      'correct_answers': question.correctAnswers,
      'options': question.options,
    });
  }

  Future<void> addQuestions(String certificationCode, List<Map<String, dynamic>> questions) async {
    try {
      final batch = _firestore.batch();
      final collectionRef = _firestore
          .collection('categories')
          .doc('cloud')
          .collection(certificationCode)
          .doc('questions')
          .collection('mcq');

      for (var questionData in questions) {
        // Create a new document reference
        final docRef = collectionRef.doc();
        batch.set(docRef, questionData);
      }

      await batch.commit();
      print('Successfully added ${questions.length} questions');
    } catch (e) {
      print('Error adding questions: $e');
      throw 'Failed to add questions: $e';
    }
  }
}