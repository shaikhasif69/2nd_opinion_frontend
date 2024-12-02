// class Doctor {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String? address;
//   final String? phone;
//   final String email;
//   final String username;
//   final String? profilePicture;
//   final String gender;
//   final List<Education> education;
//   final List<Achievement> achievements;

//   Doctor({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     this.address,
//     this.phone,
//     required this.email,
//     required this.username,
//     this.profilePicture,
//     required this.gender,
//     required this.education,
//     required this.achievements,
//   });

//   factory Doctor.fromJson(Map<String, dynamic> json) {
//     return Doctor(
//       id : json['_id'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       address: json['address'],
//       phone: json['phone'],
//       email: json['email'],
//       username: json['username'],
//       profilePicture: json['profilePicture'],
//       gender: json['gender'],
//       education: (json['education'] as List)
//           .map((e) => Education.fromJson(e))
//           .toList(),
//       achievements: (json['achievements'] as List)
//           .map((a) => Achievement.fromJson(a))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'firstName': firstName,
//       'lastName': lastName,
//       'address': address,
//       'phone': phone,
//       'email': email,
//       'username': username,
//       'profilePicture': profilePicture,
//       'gender': gender,
//       'education': education.map((e) => e.toJson()).toList(),
//       'achievements': achievements.map((a) => a.toJson()).toList(),
//     };
//   }
// }

// class Education {
//   final String title;
//   final String? subtitle;
//   final String document;

//   Education({
//     required this.title,
//     this.subtitle,
//     required this.document,
//   });

//   factory Education.fromJson(Map<String, dynamic> json) {
//     return Education(
//       title: json['title'],
//       subtitle: json['subtitle'],
//       document: json['document'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'subtitle': subtitle,
//       'document': document,
//     };
//   }
// }

// class Achievement {
//   final String title;
//   final String? document;

//   Achievement({
//     required this.title,
//     this.document,
//   });

//   factory Achievement.fromJson(Map<String, dynamic> json) {
//     return Achievement(
//       title: json['title'],
//       document: json['document'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'document': document,
//     };
//   }
// }


class Doctor {
  bool success;
  DoctorClass doctor;
  String token;

  Doctor({
    required this.success,
    required this.doctor,
    required this.token,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      success: json['success'] ?? false,
      doctor: DoctorClass.fromJson(json['doctor']),
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'doctor': doctor.toJson(),
      'token': token,
    };
  }

  Doctor copyWith({
    bool? success,
    DoctorClass? doctor,
    String? token,
  }) =>
      Doctor(
        success: success ?? this.success,
        doctor: doctor ?? this.doctor,
        token: token ?? this.token,
      );
}

class DoctorClass {
  int ratings;
  bool verified;
  String id;
  String firstName;
  String lastName;
  String phone;
  String email;
  String username;
  String profilePicture;
  String gender;
  List<Education> education;
  List<dynamic> achievements;
  List<String> specialty;

  DoctorClass({
    required this.ratings,
    required this.verified,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.username,
    required this.profilePicture,
    required this.gender,
    required this.education,
    required this.achievements,
    required this.specialty,
  });

  factory DoctorClass.fromJson(Map<String, dynamic> json) {
    return DoctorClass(
      ratings: json['ratings'] ?? 0,
      verified: json['verified'] ?? false,
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      gender: json['gender'] ?? '',
      education: (json['education'] as List)
          .map((e) => Education.fromJson(e))
          .toList(),
      achievements: json['achievements'] ?? [],
      specialty: List<String>.from(json['specialty'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ratings': ratings,
      'verified': verified,
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'username': username,
      'profilePicture': profilePicture,
      'gender': gender,
      'education': education.map((e) => e.toJson()).toList(),
      'achievements': achievements,
      'specialty': specialty,
    };
  }

  DoctorClass copyWith({
    int? ratings,
    bool? verified,
    String? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? username,
    String? profilePicture,
    String? gender,
    List<Education>? education,
    List<dynamic>? achievements,
    List<String>? specialty,
  }) =>
      DoctorClass(
        ratings: ratings ?? this.ratings,
        verified: verified ?? this.verified,
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        username: username ?? this.username,
        profilePicture: profilePicture ?? this.profilePicture,
        gender: gender ?? this.gender,
        education: education ?? this.education,
        achievements: achievements ?? this.achievements,
        specialty: specialty ?? this.specialty,
      );
}

class Education {
  String title;
  String document;
  String id;

  Education({
    required this.title,
    required this.document,
    required this.id,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      title: json['title'] ?? '',
      document: json['document'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'document': document,
      'id': id,
    };
  }

  Education copyWith({
    String? title,
    String? document,
    String? id,
  }) =>
      Education(
        title: title ?? this.title,
        document: document ?? this.document,
        id: id ?? this.id,
      );
}
