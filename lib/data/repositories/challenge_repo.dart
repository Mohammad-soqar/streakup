
import 'package:streakup/data/models/challenge.dart';
import 'package:streakup/data/services/challenge_service.dart';

class ChallengeRepo {
  final ChallengeService _challengeService = ChallengeService();


  Future<void> createChallenge(Challenge challenge) async {
    try {
      await _challengeService.createChallenge(challenge);
    } catch (e) {
      // Handle error
      throw Exception('Failed to create challenge: $e');
    }
  }
}