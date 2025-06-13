class PushMessage {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final Map<String, dynamic>? data;
  final String? imageUrl;

  PushMessage({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.data,
    this.imageUrl,
  });

  @override
  String toString() {
    return '''✅ PushMessage(
      id: $id,
      title: $title,
      body: $body,
      timestamp: $timestamp,
      imageUrl: $imageUrl
      data: $data,
    )''';
  }
}
