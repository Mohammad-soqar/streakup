import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streakup/data/models/challenge.dart';
import 'package:streakup/data/services/Storage/storage_methods.dart';

class ChallengeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collection = 'challenges';
  final StorageMethods _storageMethods = StorageMethods();
  // This class is responsible for managing challenges.
  // It will handle the creation, updating, and deletion of challenges.
  // It will also handle the retrieval of challenges from the database.

  Future<void> createChallenge(Challenge challenge) async {
    try {
      DocumentReference docRef = _firestore.collection(collection).doc();
      String challengeId = docRef.id;
      String fileName = "${challengeId}_cover_image.jpg";
      String coverImageUrl =
          await _storageMethods.uploadChallengeImageToStorage(
        challengeId: challengeId,
        file: challenge.coverImage,
        fileName: fileName,
      );

      final challengeData = {
        'id': challengeId,
        'title': challenge.title,
        'description': challenge.description,
        'creatorId': challenge.creatorId,
        'isPublic': challenge.isPublic,
        'category': challenge.category,
        'maxParticipants': challenge.maxParticipants,
        // Store the URL for the uploaded cover image
        'coverImageUrl': coverImageUrl,
        'emoji': challenge.emoji,
        'status': challenge.status.toString(),
        'rules': challenge.rules,
        'requireProof': challenge.requireProof,
        'startDate': challenge.startDate.toIso8601String(),
        'endDate': challenge.endDate?.toIso8601String(),
        'createdDate': challenge.createdDate?.toIso8601String(),
        'lastUpdated': challenge.lastUpdated?.toIso8601String(),
      };

      await docRef.set(challengeData);
    } catch (e) {
      throw Exception('Failed to create challenge: $e');
    }
  }
}
