## Currrent Issues

Your project is configured with Android NDK 26.3.11579264, but the following plugin(s) depend on a different Android NDK version:
- flutter_plugin_android_lifecycle requires Android NDK 27.0.12077973
- google_mlkit_commons requires Android NDK 27.0.12077973
- google_mlkit_text_recognition requires Android NDK 27.0.12077973
- image_picker_android requires Android NDK 27.0.12077973
- path_provider_android requires Android NDK 27.0.12077973
- tesseract_ocr requires Android NDK 27.0.12077973
Fix this issue by using the highest Android NDK version (they are backward compatible).

# Bugs