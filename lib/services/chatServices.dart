import 'dart:convert';
import 'package:doctor_opinion/components/constant.dart';
import 'package:http/http.dart' as http;

class ChatService {

  Future<List<Map<String, dynamic>>> fetchChatsForDoctor(
      String doctorId) async {
        print("hello1");
    final response = await http.get(Uri.parse('$chatIp/$doctorId'));
print("hello2");
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((chat) => chat as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load chats');
    }
  }

  Future<void> sendMessage(
      String chatId, String senderId, String message) async {
    final response = await http.post(
      Uri.parse('$chatIp/$chatId/message'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'senderId': senderId,
        'message': message,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }
}
