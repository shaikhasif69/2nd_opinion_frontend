class User {
  final bool success;
  final UserObject userObject;
  final String token;

  User({
    required this.success,
    required this.userObject,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      success: json['success'] ?? false,
      userObject: UserObject.fromJson(json['userObject']),
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'userObject': userObject.toJson(),
      'token': token,
    };
  }
}

class UserObject {
  final NotificationPreferences notificationPreferences;
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phone;
  final List<dynamic> allergies;
  final String accountStatus;
  final List<dynamic> medicalHistory;

  UserObject({
    required this.notificationPreferences,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phone,
    required this.allergies,
    required this.accountStatus,
    required this.medicalHistory,
  });


  UserObject copyWith({
    NotificationPreferences? notificationPreferences,
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? username,
    String? phone,
    List<dynamic>? allergies,
    String? accountStatus,
    List<dynamic>? medicalHistory,
  }) {
    return UserObject(
      notificationPreferences:
          notificationPreferences ?? this.notificationPreferences,
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      allergies: allergies ?? this.allergies,
      accountStatus: accountStatus ?? this.accountStatus,
      medicalHistory: medicalHistory ?? this.medicalHistory,
    );
  }

  factory UserObject.fromJson(Map<String, dynamic> json) {
    return UserObject(
      notificationPreferences:
          NotificationPreferences.fromJson(json['notificationPreferences']),
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
      allergies: json['allergies'] ?? [],
      accountStatus: json['accountStatus'] ?? '',
      medicalHistory: json['medicalHistory'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationPreferences': notificationPreferences.toJson(),
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'phone': phone,
      'allergies': allergies,
      'accountStatus': accountStatus,
      'medicalHistory': medicalHistory,
    };
  }
}

class NotificationPreferences {
  final bool email;
  final bool sms;
  final bool push;

  NotificationPreferences({
    required this.email,
    required this.sms,
    required this.push,
  });

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) {
    return NotificationPreferences(
      email: json['email'] ?? false,
      sms: json['sms'] ?? false,
      push: json['push'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'sms': sms,
      'push': push,
    };
  }
}
