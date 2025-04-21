import 'package:streakup/data/models/enums/hub_e.dart';

class Hub {
  final String id;
  final String name;
  final HubType type;
  final String createdBy;
  final List<String> members;
  final String? currentChallengeId;
  final bool isPrivate;
  final String? avatarUrl;
  final DateTime? createdDate;
  final DateTime? lastUpdated;

  Hub({
    required this.id,
    required this.name,
    required this.type,
    required this.createdBy,
    this.members = const [],
    this.currentChallengeId,
    required this.isPrivate,
    this.avatarUrl,
    this.createdDate,
    this.lastUpdated,
  });

  factory Hub.fromJson(Map<String, dynamic> json) {
    return Hub(
      id: json['id'],
      name: json['name'],
      type: HubType.fromString(json['type']),
      createdBy: json['createdBy'],
      members: List<String>.from(json['members'] ?? []),
      currentChallengeId: json['currentChallengeId'],
      isPrivate: json['isPrivate'],
      avatarUrl: json['avatarUrl'],
      createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null,
      lastUpdated: json['lastUpdated'] != null ? DateTime.parse(json['lastUpdated']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.toShortString(),
      'createdBy': createdBy,
      'members': members,
      'currentChallengeId': currentChallengeId,
      'isPrivate': isPrivate,
      'avatarUrl': avatarUrl,
      'createdDate': createdDate?.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }
}
