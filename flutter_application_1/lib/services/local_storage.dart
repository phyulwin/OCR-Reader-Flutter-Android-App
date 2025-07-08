import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import '../models/scanned_txt.dart';

class LocalStorageService {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/scanned_data.json');
  }

  static Future<List<ScannedText>> readEntries() async {
    try {
      final file = await _localFile;
      if (!file.existsSync()) return [];
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((e) => ScannedText.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveEntry(ScannedText entry) async {
    final entries = await readEntries();
    entries.add(entry);
    final file = await _localFile;
    await file.writeAsString(json.encode(entries.map((e) => e.toJson()).toList()));
  }

  static Future<void> deleteEntry(ScannedText entryToDelete) async {
    final file = await _localFile;
    final entries = await readEntries();

    entries.removeWhere((entry) =>
        entry.text == entryToDelete.text &&
        entry.timestamp.toIso8601String() == entryToDelete.timestamp.toIso8601String());

    await file.writeAsString(jsonEncode(entries.map((e) => e.toJson()).toList()));
  }
  
}
