class Challenger {
  final String id;
  final String fullName;
  final String firstName;
  final String lastName;
  final String email;
  final String? profilePhoto;
  final String gender;
  final DateTime dateOfBirth;
  final List<String> friends;
  final List<String> incomingRequests;
  final List<String> outgoingRequests;
  final String userType;
  final bool? verified;
  final DateTime? createdDate;
  final DateTime? lastUpdated;

  // Computed property
  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  Challenger({
    required this.id,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profilePhoto,
    required this.gender,
    required this.dateOfBirth,
    this.friends = const [],
    this.incomingRequests = const [],
    this.outgoingRequests = const [],
    required this.userType,
    this.verified,
    this.createdDate,
    this.lastUpdated,
  });

  factory Challenger.fromJson(Map<String, dynamic> json) {
    return Challenger(
      id: json['id'],
      fullName: json['fullName'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'],
      profilePhoto: json['profilePhoto'],
      gender: json['gender'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      friends: List<String>.from(json['friends'] ?? []),
      incomingRequests: List<String>.from(json['incomingRequests'] ?? []),
      outgoingRequests: List<String>.from(json['outgoingRequests'] ?? []),
      userType: json['userType'],
      verified: json['verified'],
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'profilePhoto': profilePhoto,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'friends': friends,
      'incomingRequests': incomingRequests,
      'outgoingRequests': outgoingRequests,
      'userType': userType,
      'verified': verified,
      'createdDate': createdDate?.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }
}
