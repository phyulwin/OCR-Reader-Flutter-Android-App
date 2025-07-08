import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_application_1/models/scanned_txt.dart';
import 'package:flutter_application_1/services/local_storage.dart';

Future<String?> scanImage(String imagePath) async {
  final inputImage = InputImage.fromFilePath(imagePath);
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  try {
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();

    final String text = recognizedText.text;

    if (text.isNotEmpty) {
      final scanned = ScannedText(
        text: text,
        timestamp: DateTime.now(),
      );
      await LocalStorageService.saveEntry(scanned);
    }

    return text;
  } catch (e) {
    print('OCR failed: $e');
    return null;
  }
}

// No longer using the package below. Inaccurate for handwritten text.

/* import 'package:tesseract_ocr/tesseract_ocr.dart';
import 'package:tesseract_ocr/ocr_engine_config.dart';

Future<String?> scanImage(String imagePath) async {
  try {
    final config = OCRConfig(
      language: 'eng',
      engine: OCREngine.tesseract,
    );

    String text = await TesseractOcr.extractText(imagePath, config: config);
    return text;
  } catch (e) {
    print('OCR Error: $e');
    return null;
  }
} */
