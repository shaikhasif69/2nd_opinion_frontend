import 'dart:convert';
import 'package:doctor_opinion/components/constant.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<Map<String, dynamic>> collectUserInfo(
      Map<String, dynamic> userInfo) async {
    print("helllooo?");

    final response = await http.post(
      Uri.parse('$ip/user/collectUserInfo'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userInfo),
    );
    print("-------------------00");
    print(response);
    return jsonDecode(response.body);
  }
  

  static Future<bool> validateEmail(String email) async {
    try {
      // return true;
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
    print("THIS IS OTP: " + otp);
     print("Sending email: " + email);
    final response = await http.post(
      Uri.parse('$ip/user/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );
    print("response body: " + response.body);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$ip/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    return jsonDecode(response.body);
  }
}
