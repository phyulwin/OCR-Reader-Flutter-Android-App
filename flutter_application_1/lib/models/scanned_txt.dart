class ScannedText {
  final String text;
  final DateTime timestamp;

  ScannedText({required this.text, required this.timestamp});

  Map<String, dynamic> toJson() => {
    'text': text,
    'timestamp': timestamp.toIso8601String(),
  };

  factory ScannedText.fromJson(Map<String, dynamic> json) => ScannedText(
    text: json['text'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
