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
      profilePicture: json['profilePicture'] ?? 'https://res.cloudinary.com/dtgdwiyxm/image/upload/v1724510467/samples/man-portrait.jpg',
      gender: json['gender'] ?? '',
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
        specialty: specialty ?? this.specialty,
      );
}
