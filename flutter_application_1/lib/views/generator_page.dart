// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/services/ocr_service.dart';
import 'package:flutter_application_1/utils/error_message.dart'; 

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  String? scannedText;

  Future<void> _pickImageAndScan() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final XFile file = pickedFile;
        String? result = await scanImage(file.path);

        // Ensure the context is still valid before using it
        if (!mounted) return;

        if (result != null && result.isNotEmpty) {
          _showResultDialog(result);
        } else {
          _showErrorDialog("No text was detected in the image.");
        }
      }
    } catch (e) {
      ErrorMessage.show(context, 'Generator Page failed: $e');
    }
  }

  void _showResultDialog(String result) {
    try {
       showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Scanned Text'),
            content: SingleChildScrollView(child: Text(result)),
            actions: [
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: result));
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                },
                child: const Text('Copy'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );    } 
    catch (e) {
      ErrorMessage.show(context, 'Generator Page failed: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error", style: TextStyle(color: Colors.red)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Generator'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _pickImageAndScan,
          child: const Text("Pick Image & Scan"),
        ),
      ),
    );
  }
}
