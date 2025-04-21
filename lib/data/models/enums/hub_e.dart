enum HubType {
  group,
  duo;

  static HubType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'group':
        return HubType.group;
      case 'duo':
        return HubType.duo;
      default:
        throw Exception('Unknown HubType: $value');
    }
  }

  String toShortString() => name;
}
