class Participant {
  final String userId;
  final DateTime joinedAt;
  final int currentStreak;
  final int longestStreak;
  final int completedDays;
  final int proofsSubmitted;
  final DateTime? lastCheckIn;
  final String? notes;

  Participant({
    required this.userId,
    required this.joinedAt,
    required this.currentStreak,
    required this.longestStreak,
    required this.completedDays,
    required this.proofsSubmitted,
    this.lastCheckIn,
    this.notes,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      userId: json['userId'],
      joinedAt: DateTime.parse(json['joinedAt']),
      currentStreak: json['currentStreak'],
      longestStreak: json['longestStreak'],
      completedDays: json['completedDays'],
      proofsSubmitted: json['proofsSubmitted'],
      lastCheckIn: json['lastCheckIn'] != null ? DateTime.parse(json['lastCheckIn']) : null,
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'joinedAt': joinedAt.toIso8601String(),
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'completedDays': completedDays,
      'proofsSubmitted': proofsSubmitted,
      'lastCheckIn': lastCheckIn?.toIso8601String(),
      'notes': notes,
    };
  }
}
