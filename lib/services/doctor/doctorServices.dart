
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/models/patient/User.dart';
import 'package:doctor_opinion/provider/userProviders/UserProviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorServices{
    static Future<void> fetchAllPatients(BuildContext context) async {
    final response = await http.get(Uri.parse('$ip/doctor/get-all-patient'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      print("this is the response: " + jsonResponse.toString());
      List<User> users =
          jsonResponse.map((data) => User.fromJson(data)).toList();

      Provider.of<UserProvider>(context, listen: false).setUsers(users);
    } else {
      throw Exception('Failed to load users');
    }
  }
}