// lib/utils/admin_panel.dart
import 'package:flutter/material.dart';
import 'question_uploader.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await QuestionUploader.uploadAWSQuestions();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('AWS questions uploaded')),
                );
              },
              child: Text('Upload AWS Questions'),
            ),
            ElevatedButton(
              onPressed: () async {
                await QuestionUploader.uploadAzureQuestions();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Azure questions uploaded')),
                );
              },
              child: Text('Upload Azure Questions'),
            ),
            ElevatedButton(
              onPressed: () async {
                await QuestionUploader.uploadGCPQuestions();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('GCP questions uploaded')),
                );
              },
              child: Text('Upload GCP Questions'),
            ),
          ],
        ),
      ),
    );
  }
}