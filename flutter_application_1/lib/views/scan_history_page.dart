import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/scanned_txt.dart';
import 'package:flutter_application_1/services/local_storage.dart';

class ScanHistoryPage extends StatefulWidget {
  const ScanHistoryPage({Key? key}) : super(key: key);

  @override
  State<ScanHistoryPage> createState() => _ScanHistoryPageState();
}

class _ScanHistoryPageState extends State<ScanHistoryPage> {
  List<ScannedText> _entries = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final data = await LocalStorageService.readEntries();
    setState(() {
      _entries = data;
      _loading = false;
    });
  }

  Future<void> _deleteEntry(ScannedText entry) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text('Are you sure you want to delete this scanned text?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await LocalStorageService.deleteEntry(entry);
      setState(() {
        _entries.removeWhere((e) =>
            e.text == entry.text &&
            e.timestamp.toIso8601String() == entry.timestamp.toIso8601String());
      });
    }
  }

  void _showFullTextDialog(String fullText) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scanned Text'),
        content: SingleChildScrollView(child: Text(fullText)),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: fullText));
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan History')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _entries.isEmpty
              ? const Center(child: Text('No scans saved yet.'))
              : ListView.builder(
                  itemCount: _entries.length,
                  itemBuilder: (context, index) {
                    final entry = _entries[index];
                    final preview = entry.text.length > 30
                        ? '${entry.text.substring(0, 30)}...'
                        : entry.text;

                    return ListTile(
                      leading: const Icon(Icons.description),
                      title: Text(preview),
                      subtitle: Text(
                        entry.timestamp.toLocal().toString(),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteEntry(entry),
                      ),
                      onTap: () => _showFullTextDialog(entry.text),
                    );
                  },
                ),
    );
  }
}
