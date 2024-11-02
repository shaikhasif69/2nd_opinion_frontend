import 'dart:convert';
import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/models/patient/User.dart';
import 'package:doctor_opinion/models/doctor/Doctor.dart';
import 'package:doctor_opinion/provider/UserProviders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserService {
  Future<Map<String, dynamic>> collectUserInfo(
      Map<String, dynamic> userInfo) async {
    final response = await http.post(
      Uri.parse('$ip/user/collectUserInfo'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userInfo),
    );

    if (response.statusCode == 200) {
      print("response body: " + response.body);
      final jsonResponse = jsonDecode(response.body);
      print("json Response: " + jsonResponse.toString());

      // if (jsonResponse.containsKey('user')) {
      //   User user = User.fromJson(jsonResponse['user']);
      // } else {
      //   throw Exception('User data not found in response');
      // }

      // User user = User.fromJson(jsonResponse['user']);

      return jsonResponse;
    } else {
      throw Exception('Failed to collect user information');
    }
  }

  static Future<bool> validateEmail(String email) async {
    try {
      var response = await http.get(
        Uri.parse(ip + "/user/email/" + email),
      );

      return jsonDecode(response.body)['available'];
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    print("email : " + email + " otp: " + otp);
    final response = await http.post(
      Uri.parse('$ip/user/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      print("json Response: " + jsonResponse.toString());

      if (jsonResponse.containsKey('user')) {
        User user = User.fromJson(jsonResponse['user']);
      } else {
        throw Exception('User data not found in response');
      }

      User user = User.fromJson(jsonResponse['user']);

      return jsonResponse;
    } else {
      throw Exception('Failed to verify OTP');
    }
  }

  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final response = await http.post(
      Uri.parse('$ip/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      User user = User.fromJson(jsonResponse['user']);
      return jsonResponse;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<Doctor>> fetchAllDoctors() async {
    try {
      final response = await http.get(
        Uri.parse('$ip/api/doctor/get-all-doctors'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        // Map each JSON item to a Doctor instance and return the list
        List<Doctor> doctors = jsonResponse.map((doctorJson) {
          return Doctor.fromJson(doctorJson);
        }).toList();

        return doctors;
      } else {
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error fetching doctors');
    }
  }
}
