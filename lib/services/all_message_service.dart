import 'dart:convert';
import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/models/all_messages_model.dart';
import 'package:doctor_opinion/services/authServices.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MessageService {
  SharedPreferences prefs = AuthService.pref;

  Future<List<AllMessagesModel>> fetchAllMessages(String userId) async {
    try {
      print("workign 1 userId; " + userId);
      final token =   prefs.getString("user_token");
      final response = await http.get(
        Uri.parse('$ip/chat/get-all-chats/$userId'),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );
      print("workign 2");
      print("response code: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        print("workign 3");

        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse
            .map((json) => AllMessagesModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      throw Exception('Error fetching messages: $e');
    }
  }
}
