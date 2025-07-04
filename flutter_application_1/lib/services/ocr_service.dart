import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

Future<String?> scanImage(String imagePath) async {
  final inputImage = InputImage.fromFilePath(imagePath);
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  try {
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    return recognizedText.text;
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
