import 'dart:convert';
import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/models/patient/User.dart';
import 'package:doctor_opinion/models/doctor/Doctor.dart';
import 'package:doctor_opinion/services/authServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  SharedPreferences prefs = AuthService.pref;

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

      // User user = User.fromJson(jsonResponse['user']);

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
    print("response code: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
    else if(response.statusCode == 404){
      return {"error": "Something Went Wrong"};
    }
     else {
      return {'error': 'Invalid credentials, please try again'};
    }
  }

  Future<List<Doctor>> fetchAllDoctors() async {
    try {
      var token = prefs.getString("user_token");
      final response = await http.get(
        Uri.parse('$ip/api/doctor/get-all-doctors'),
        headers: {
          'Authorization': token.toString(),
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);

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

  Future<List<DoctorClass>> fetchTopRatedDoctors() async {
    try {
      var token = prefs.getString("user_token");
      final response = await http.get(
        Uri.parse('$ip/doctor/top-doctors'),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json'
        },
      );

      print("working top " +  response.statusCode.toString());

      if (response.statusCode == 200) {
      print("working top 2");

        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("json response is: " + jsonResponse.toString());

      List<DoctorClass> doctors = jsonResponse
          .map((doctor) => DoctorClass.fromJson(doctor as Map<String, dynamic>))
          .toList();

      return doctors;
      } else {
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error fetching top rated doctors');
    }
  }

  Future<List<DoctorClass>> fetchAvailableDoctors(String currentTime) async {
    try {
      var token = prefs.getString("user_token");

      final response = await http.get(
        Uri.parse('$ip/doctor/available-doctors?currentTime=$currentTime'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );


      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((doctor) => DoctorClass.fromJson(doctor)).toList();
      } else {
        throw Exception("Failed to fetch available doctors");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<List<DoctorClass>> searchDoctorsByName(String name) async {
    try {
      var token = prefs.getString("user_token");
      final response = await http.get(
        Uri.parse('$ip/doctor/search-doctors?name=$name'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((doctor) => DoctorClass.fromJson(doctor)).toList();
      } else {
        throw Exception("Failed to search doctors");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<List<String>> fetchAllSpecialties() async {
  try {
    var token = prefs.getString("user_token");
    final response = await http.get(
      Uri.parse('$ip/doctor/get-all-specialties'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch specialties");
    }
  } catch (e) {
    print("Error: $e");
    rethrow;
  }
}

Future<List<DoctorClass>> fetchDoctorsBySpecialty(String specialty) async {
  try {
    var token = prefs.getString("user_token");
    final response = await http.get(
      Uri.parse('$ip/doctor/doctor-by-speciality/specialty?specialty=$specialty'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((doctor) => DoctorClass.fromJson(doctor)).toList();
    } else {
      throw Exception("Failed to fetch doctors by specialty");
    }
  } catch (e) {
    print("Error: $e");
    rethrow;
  }
}

Future<List<DoctorClass>> fetchDoctorsByLocation(String city) async {
  try {
    var token = prefs.getString("user_token");
    final response = await http.get(
      Uri.parse('$ip/doctor/doctors-by-location?city=$city'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((doctor) => DoctorClass.fromJson(doctor)).toList();
    } else {
      throw Exception("Failed to fetch doctors by location");
    }
  } catch (e) {
    print("Error: $e");
    rethrow;
  }
}


}
