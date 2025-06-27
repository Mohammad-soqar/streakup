import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:streakup/data/models/enums/challengestatus_e.dart';
import 'package:streakup/data/repositories/challenge_repo.dart';

class ChallengeViewmodel extends ChangeNotifier {
  // Repository
  final ChallengeRepo _challengeRepo = ChallengeRepo();
  // Text Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final maxParticipantsController = TextEditingController();
  final emojiController = TextEditingController();

  // Other Fields
  bool isPublic = true;
  bool requireProof = false;
  late ChallengeStatus _status;

  List<String> rules = [];
  DateTime? startDate;
  DateTime? endDate;
  Uint8List? coverImageBytes;
  String coverImageUrl = '';

  Future<void> createChallenge(challenge) async {
    // Validate inputs
    if (titleController.text.isEmpty) {
      throw Exception('Title cannot be empty');
    }
    if (descriptionController.text.isEmpty) {
      throw Exception('Description cannot be empty');
    }
    if (categoryController.text.isEmpty) {
      throw Exception('Category cannot be empty');
    }
    if (maxParticipantsController.text.isEmpty) {
      throw Exception('Max Participants cannot be empty');
    }
    if (coverImageBytes == null) {
      throw Exception('Cover Image cannot be empty');
    }

    // Call repository to create challenge
    await _challengeRepo.createChallenge(challenge);
  }
}
