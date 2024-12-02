import 'package:doctor_opinion/models/doctor/Doctor.dart';
import 'package:hive/hive.dart';

part 'doctor_hive.g.dart';

@HiveType(typeId: 1) 
class DoctorHive {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String? address;

  @HiveField(4)
  final String? phone;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final String username;

  @HiveField(7)
  final String? profilePicture;

  @HiveField(8)
  final String gender;

  DoctorHive({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.address,
    this.phone,
    required this.email,
    required this.username,
    this.profilePicture,
    required this.gender,
  });

  factory DoctorHive.fromDoctor(DoctorClass doctor) {
    return DoctorHive(
      id: doctor.id,
      firstName: doctor.firstName,
      lastName: doctor.lastName,
      address: "",
      phone: doctor.phone,
      email: doctor.email,
      username: doctor.username,
      profilePicture: doctor.profilePicture,
      gender: doctor.gender,
    );
  }

  DoctorClass toDoctor() {
    return DoctorClass(
      id: id ?? '',
      firstName: firstName,
      lastName: lastName,
      phone: phone.toString(),
      email: email,
      username: username,
      profilePicture: profilePicture.toString(),
      gender: gender,
       ratings: 0, verified: false, specialty: [],
    );
  }
}
