import 'dart:convert';
import 'dart:io';
import 'package:doctor_opinion/models/hiveModels/doctor_hive.dart';
import 'package:doctor_opinion/services/hiveServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_opinion/services/doctor/Registeration.dart';
import 'package:doctor_opinion/models/doctor/Doctor.dart';

class DoctorProvider with ChangeNotifier {
  Doctor? _doctor;
  bool _isSubmitting = false;

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
      bool success = await DoctorRegisterationApi.signin(
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

  Future<void> verifyDoctorOtp({
    required String email,
    required String otp,
  }) async {
    _isSubmitting = true;
    notifyListeners();
    try {
      var response = await DoctorRegisterationApi.verifyDocOtp(email, otp);
      if (response['message'] == 'Success') {
        var doctorData = response['doctor']; 
        Doctor doctor = Doctor.fromJson(doctorData);
        DoctorHive hiveDoctor = DoctorHive(
      id: doctor.id,
      firstName: doctor.firstName,
      lastName: doctor.lastName,
      address: doctor.address,
      phone: doctor.phone,
      email: doctor.email,
      username: doctor.username,
      profilePicture: doctor.profilePicture,
      gender: doctor.gender,
    );
    
    final hiveService = HiveService();
    await hiveService.saveDcotr(hiveDoctor);
        setDoctor(doctor);
        print("Doctor is logged in: ${isLoggedIn}");
        print("Doctor logged in successfully!");
      } else {
        print("OTP verification failed: ${response['message']}");
      }
    } catch (e) {
      print("error: " + e.toString());
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
