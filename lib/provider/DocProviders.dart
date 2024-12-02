import 'dart:convert';
import 'dart:io';
import 'package:doctor_opinion/models/hiveModels/doctor_hive.dart';
import 'package:doctor_opinion/services/doctorServices.dart';
import 'package:doctor_opinion/services/hiveServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_opinion/models/doctor/Doctor.dart';

class DoctorProvider with ChangeNotifier {
  Doctor? _doctor;
  bool _isSubmitting = false;
  // List<DoctorClass> _doctors;

  List<DoctorClass> _doctors = [];


  Doctor? get doctor => _doctor;
  bool get isSubmitting => _isSubmitting;

  void setDoctor(Doctor doctor) {
    _doctor = doctor;
    notifyListeners();
  }

  void updateDoctor(Doctor updatedDoctor) {
    _doctor = updatedDoctor;
    notifyListeners();
  }
  
  List<DoctorClass>? get doctors => _doctors;

  void setDoctors(List<DoctorClass> doctors){
    _doctors  = doctors;
    notifyListeners();
  }

  bool get hasDoctors => _doctors != null && _doctors!.isNotEmpty;


  void clearDoctor() {
    _doctor = null;
    notifyListeners();
  }

  bool get isLoggedIn => _doctor != null;

  Future<void> registerDoctor({
    required String firstName,
    required String lastName,
    required String age,
    required String gender,
    required String phone,
    required String email,
    required String username,
    required String password,
    required File profile,
  }) async {
    _isSubmitting = true;
    notifyListeners();
    try {
      bool success = await DoctorServices.signin(
        firstName: firstName,
        lastname: lastName,
        age: age,
        gender: gender,
        phone: phone,
        email: email,
        username: username,
        password: password,
        profile: profile,
      );
      print('Doctor registered: $success');

      if (success) {
        print("hurray the sucksess");
        notifyListeners();
      } else {
        print("no success");
      }
    } catch (e) {
      print("error: " + e.toString());
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
