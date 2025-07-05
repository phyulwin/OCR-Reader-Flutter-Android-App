# flutter_application_1

PDF scanner or handwritten text scanner OCR from PDF/handwritten sources with summarization. 
(offline support)

## App features

Live image text dectection not available.

+ upload image (.jpg / .jpeg / .png / .webp)
+ take a picture (if there is no image ready to upload)
+ upload a document (pdf etc.) -> render to image for scanning 

App scans the image that includes text or handwriting
(supported language: english for now)

App generates the scanned text in plain text form that the user can copy and paste elsewhere.

Stretch idea: 
- Rewrite by AI will fix spelling mistakes and wrongly scanned words or phrases (checkbox item)
- also option to print out the scanned text in the original format (paragraphs, rows, and columns)

+ local file storage system
Key:value -- scanned image + plain text document
No cloud storage for privacy reasons. 
Delete files that are not needed. 

# References & Tutorials 
[Flutter OCR using Google ML Kit | Flutter Text Recognition 2024](https://youtu.be/GmhkXH8fO-A?si=9M3Zhn6mYM5RXiw4)
[Google's ML Kit for Flutter](https://pub.dev/packages/google_ml_kit)

[tesseract_ocr 0.5.0 ](https://pub.dev/packages/tesseract_ocr) 

[flutter_genius_scan 5.11.1](https://pub.dev/packages/flutter_genius_scan)
needs to buy license key

[flutter_document_reader_api 8.1.306](https://pub.dev/packages/flutter_document_reader_api)
Regula Document Reader SDK allows you to read various kinds of identification documents, passports, driving licenses, ID cards, etc. All processing is performed completely offline on your device. --> cannot read handwritten text

[Scanbot Flutter Document Scanner SDK and Data Capture Modules](https://pub.dev/packages/scanbot_sdk) 
The Scanbot SDK provides high-level APIs that let you integrate high-quality document scanning and data extraction into your mobile apps and websites. It runs on all common mobile devices entirely offline, without transmitting data to our or third-party servers. --> requires license key


## Running the emulator in powershell
`& "C:\Users\{USER-NAME}\AppData\Local\Android\Sdk\emulator\emulator.exe" -avd {EMULATOR-NAME}`

& "C:\Users\646ca\AppData\Local\Android\Sdk\emulator\emulator.exe" -avd Small_Phone <--delete this later

#### some other commands

`flutter pub get` - fetches and installs all the dependencies (packages and plugins) listed in pubspec.yaml file

`flutter devices`

`flutter run` or start in debug mode

VS code settings - hot reload enabled allifDirty and autosave on