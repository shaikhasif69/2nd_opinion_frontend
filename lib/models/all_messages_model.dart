class AllMessagesModel {
  String id;
  String firstName;
  String lastName;
  String username;
  String profilePicture;
  String? lastMessage; // Nullable to account for cases where no messages exist

  AllMessagesModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.profilePicture,
    this.lastMessage,
  });

  AllMessagesModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? profilePicture,
    String? lastMessage,
  }) =>
      AllMessagesModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        username: username ?? this.username,
        profilePicture: profilePicture ?? this.profilePicture,
        lastMessage: lastMessage ?? this.lastMessage,
      );

  factory AllMessagesModel.fromJson(Map<String, dynamic> json) {
    return AllMessagesModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      profilePicture: json['profilePicture'],
      lastMessage: json['lastMessage'],  
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'profilePicture': profilePicture,
      'lastMessage': lastMessage,  
    };
  }
}
