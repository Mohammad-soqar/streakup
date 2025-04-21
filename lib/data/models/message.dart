import 'package:streakup/data/models/enums/message_e.dart';

class Message {
  final String id;
  final String senderId;
  final String text;
  final MessageType type;
  final String? imageUrl;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.type,
    this.imageUrl,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['senderId'],
      text: json['text'],
      type: MessageType.fromString(json['type']),
      imageUrl: json['imageUrl'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'text': text,
      'type': type.toShortString(),
      'imageUrl': imageUrl,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
