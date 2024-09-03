class Doctor {
  final String id;
  final String firstName;
  final String lastName;
  final String? address;
  final String? phone;
  final String email;
  final String username;
  final String? profilePicture;
  final String gender;
  final List<Education> education;
  final List<Achievement> achievements;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.address,
    this.phone,
    required this.email,
    required this.username,
    this.profilePicture,
    required this.gender,
    required this.education,
    required this.achievements,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id : json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      username: json['username'],
      profilePicture: json['profilePicture'],
      gender: json['gender'],
      education: (json['education'] as List)
          .map((e) => Education.fromJson(e))
          .toList(),
      achievements: (json['achievements'] as List)
          .map((a) => Achievement.fromJson(a))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'phone': phone,
      'email': email,
      'username': username,
      'profilePicture': profilePicture,
      'gender': gender,
      'education': education.map((e) => e.toJson()).toList(),
      'achievements': achievements.map((a) => a.toJson()).toList(),
    };
  }
}

class Education {
  final String title;
  final String? subtitle;
  final String document;

  Education({
    required this.title,
    this.subtitle,
    required this.document,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      title: json['title'],
      subtitle: json['subtitle'],
      document: json['document'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'document': document,
    };
  }
}

class Achievement {
  final String title;
  final String? document;

  Achievement({
    required this.title,
    this.document,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      title: json['title'],
      document: json['document'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'document': document,
    };
  }
}
