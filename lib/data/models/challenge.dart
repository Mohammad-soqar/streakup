import 'dart:typed_data';

import 'package:streakup/data/models/enums/challengestatus_e.dart';

class Challenge {
  final String id;
  final String title;
  final String description;
  final String creatorId;
  final bool isPublic;
  final String category;
  final int maxParticipants;
  final Uint8List coverImage;
  final String coverImageUrl;
  final String? emoji;
  final ChallengeStatus status;
  final List<String> rules;
  final bool requireProof;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime? createdDate;
  final DateTime? lastUpdated;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.creatorId,
    required this.isPublic,
    required this.category,
    required this.maxParticipants,
    required this.coverImage,
    required this.coverImageUrl,
    this.emoji,
    required this.status,
    this.rules = const [],
    required this.requireProof,
    required this.startDate,
    this.endDate,
    this.createdDate,
    this.lastUpdated,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      creatorId: json['creatorId'],
      isPublic: json['isPublic'],
      category: json['category'],
      maxParticipants: json['maxParticipants'],
      coverImage: json['coverImage'],
      coverImageUrl: json['coverImageUrl'],
      emoji: json['emoji'],
      status: ChallengeStatus.fromString(json['status']),
      rules: List<String>.from(json['rules'] ?? []),
      requireProof: json['requireProof'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null,
      lastUpdated: json['lastUpdated'] != null ? DateTime.parse(json['lastUpdated']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creatorId': creatorId,
      'isPublic': isPublic,
      'category': category,
      'maxParticipants': maxParticipants,
      'coverImage': coverImage,
      'coverImageUrl': coverImageUrl,
      'emoji': emoji,
      'status': status.toShortString(),
      'rules': rules,
      'requireProof': requireProof,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'createdDate': createdDate?.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }
}
