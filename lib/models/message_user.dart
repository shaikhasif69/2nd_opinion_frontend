// models/user.dart
import '../models/roles.dart';

class User {
  final String id;
  final Role role;

  User({required this.id, required this.role});
}
