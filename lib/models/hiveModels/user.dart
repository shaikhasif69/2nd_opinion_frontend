import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class HiveUser extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String phone;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final String username;

  @HiveField(7)
  final String profilePicture;

  @HiveField(8)
  final String gender;





  HiveUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.address = '',
    required this.phone,
    required this.email,
    required this.username,
    this.profilePicture = '',
    this.gender = 'Other',
  });
}
