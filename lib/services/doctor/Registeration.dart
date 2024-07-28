import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:doctor_opinion/models/doctor/degrees.dart';
import 'package:doctor_opinion/services/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class DoctorRegisterationApi {
  static Future<bool> validateUsername(String username) async {
    try {
      return true;
      var response = await http.get(
        Uri.parse(ip + "/api/doctor/username/" + username),
      );
      if (response.statusCode == 400) {
        print("sata");
        return false;
      } else {
        return jsonDecode(response.body)['available'];
      }
    } catch (e) {
      print(e);
      dev.log(e.toString());
      return false;
    }
  }

  static Future<bool> validateEmail(String email) async {
    try {
      return true;
      var response = await http.get(
        Uri.parse(ip + "/api/doctor/email/" + email),
      );

      return jsonDecode(response.body)['available'];
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> validatePhone(String phone) async {
    try {
      return true;
      var response = await http.get(
        Uri.parse(ip + "/api/doctor/phone/" + phone),
      );

      return jsonDecode(response.body)['available'];
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> signin(
      {required firstName,
      required lastname,
      required age,
      required gender,
      required phone,
      required email,
      required username,
      required password,
      required File profile}) async {
    try {
      return true;
      String url = ip + "/api/doctor/collectDoctorInfo";
      print(url);
      var req = http.MultipartRequest("POST", Uri.parse(url));
      req.fields['firstName'] = firstName;
      req.fields['lastName'] = lastname;
      req.fields['age'] = age;
      req.fields['gender'] = gender;
      req.fields['email'] = email;
      req.fields['username'] = username;
      req.fields['password'] = password;
      var pic =
          await http.MultipartFile.fromPath("profilePicture", profile.path);
      req.files.add(pic);
      // req.files.add(pic);
      List<List<String>> lis = [];
      List<http.MultipartFile> allFiles = [];

      await Future.forEach(selectedMedicalDegreesAndSpecializations.keys,
          (e) async {
        await Future.forEach(selectedMedicalDegreesAndSpecializations[e]!,
            (v) async {
          lis.add([e, v.entries.first.key]);
          http.MultipartFile f = await http.MultipartFile.fromPath(
            "doc",
            filename: v.entries.first.key + ".pdf",
            v.entries.first.value!.path,
          );
          allFiles.add(f);
        });
      });

      req.files.addAll(allFiles);

      req.fields['educationList'] = jsonEncode(lis);

      var res = await req.send();
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
