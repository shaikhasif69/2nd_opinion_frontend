enum Role { user, doctor }

extension RoleExtension on Role {
  static Role? fromString(String roleString) {
    switch (roleString) {
      case 'User':
        return Role.user;
      case 'Doctor':
        return Role.doctor;
      default:
        return null;
    }
  }

  String toShortString() {
    return toString().split('.').last;
  }
}
