import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'http://192.168.0.102:3000/api/user';

  Future<Map<String, dynamic>> collectUserInfo(
      Map<String, dynamic> userInfo) async {
    print("helllooo?");

    final response = await http.post(
      Uri.parse('http://192.168.0.102:3000/api/user/collectUserInfo'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userInfo),
    );
    print("-------------------00");
    print(response);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    print("THIS IS OTP: " + otp);
    final response = await http.post(
      Uri.parse('http://192.168.0.102:3000/api/user/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );
    print("response body: " + response.body);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    return jsonDecode(response.body);
  }
}
