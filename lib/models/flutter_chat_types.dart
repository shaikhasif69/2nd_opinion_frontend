enum Role { user, doctor }

class User {
  final String id;
  final Role role;

  User({required this.id, required this.role});
}

class TextMessage {
  final String id;
  final User author;
  final String text;
  final int createdAt;

  TextMessage({
    required this.id,
    required this.author,
    required this.text,
    required this.createdAt,
  });
}

Role mapStringToRole(String roleString) {
  switch (roleString) {
    case "User":
      return Role.user;
    case "Doctor":
      return Role.doctor;
    default:
      return Role.user; // Default fallback
  }
}
