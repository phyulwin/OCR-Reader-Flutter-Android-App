import 'package:flutter/material.dart';

class ErrorMessage {
  static void show(BuildContext context, String message, {String title = 'Error'}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(color: Colors.red),
        ),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}