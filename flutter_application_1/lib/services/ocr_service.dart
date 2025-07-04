import 'package:tesseract_ocr/tesseract_ocr.dart';
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
}