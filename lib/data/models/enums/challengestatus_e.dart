enum ChallengeStatus {
  draft,
  active,
  completed;

  static ChallengeStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'draft':
        return ChallengeStatus.draft;
      case 'active':
        return ChallengeStatus.active;
      case 'completed':
        return ChallengeStatus.completed;
      default:
        throw Exception('Unknown ChallengeStatus: $value');
    }
  }

  String toShortString() => name;
}
