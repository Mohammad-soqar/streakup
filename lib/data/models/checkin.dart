class Checkin {
  final String userId;
  final DateTime date;
  final bool completed;
  final String? note;
  final String? proofImageUrl;
  final DateTime timestamp;

  Checkin({
    required this.userId,
    required this.date,
    required this.completed,
    this.note,
    this.proofImageUrl,
    required this.timestamp,
  });

  factory Checkin.fromJson(Map<String, dynamic> json) {
    return Checkin(
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      completed: json['completed'],
      note: json['note'],
      proofImageUrl: json['proofImageUrl'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String(),
      'completed': completed,
      'note': note,
      'proofImageUrl': proofImageUrl,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
