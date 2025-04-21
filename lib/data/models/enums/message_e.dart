enum MessageType {
  text,
  image,
  challengeUpdate;

  static MessageType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'challenge_update':
        return MessageType.challengeUpdate;
      default:
        throw Exception('Unknown MessageType: $value');
    }
  }

  String toShortString() => switch (this) {
        MessageType.text => 'text',
        MessageType.image => 'image',
        MessageType.challengeUpdate => 'challenge_update',
      };
}
