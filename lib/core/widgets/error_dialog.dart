import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const ErrorDialog({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(error),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onRetry();
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
