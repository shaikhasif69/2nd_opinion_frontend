import 'dart:convert';
import 'package:doctor_opinion/services/authServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  static const String baseUrl = "http://192.168.101.46:3000/api/chat";
  late IO.Socket socket;
  SharedPreferences prefs = AuthService.pref;


  Future<Map<String, dynamic>?> getOrCreateChat(String userId, String doctorId) async {
    try {
      var token = prefs.getString("user_token");

      final response = await http.get(Uri.parse("$baseUrl/$userId/$doctorId"), headers: {
        'Content-Type': 'application/json',
        'Authorization' : "Bearer $token"
      });

      if (response.statusCode == 200) {
        print("worked??");
        return jsonDecode(response.body);
      } else {
        debugPrint("Error: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception in getOrCreateChat: $e");
    }
    return null;
  }

  Future<Map<String, dynamic>?> sendMessage(String chatId, String senderId, String senderModel, String text) async {
    try {
      var token = prefs.getString("user_token");

      final response = await http.post(
        Uri.parse("$baseUrl/$chatId/message"),
        headers: {'Content-Type': 'application/json', 'Authorization' : "Bearer $token"},
        body: jsonEncode({
          "senderId": senderId,
          "senderModel": senderModel,
          "text": text,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint("Error: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception in sendMessage: $e");
    }
    return null;
  }

  // ** Get Messages **
  Future<List<dynamic>?> getMessages(String chatId) async {
    try {
      var token = prefs.getString("user_token");

      final response = await http.get(Uri.parse("$baseUrl/$chatId"),
        headers: {'Content-Type': 'application/json', 'Authorization' : "Bearer $token"},

      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        debugPrint("Error: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception in getMessages: $e");
    }
    return null;
  }

  // ** Initialize Socket.IO Connection **
  void initSocketConnection() {
    socket = IO.io(
      "http://192.168.101.46:3000",
      IO.OptionBuilder()
          .setTransports(['websocket']) // Set the transport to WebSocket
          .enableAutoConnect() // Auto-connect on initialization
          .build(),
    );

    socket.onConnect((_) {
      debugPrint("Connected to Socket.IO server.");
    });

    socket.onDisconnect((_) {
      debugPrint("Disconnected from Socket.IO server.");
    });

    socket.onError((data) {
      debugPrint("Socket.IO Error: $data");
    });
  }

  // ** Join a Chat Room **
  void joinChatRoom(String userId, String doctorId) {
    final roomId = "${userId}_$doctorId";
    socket.emit("joinChat", {"userId": userId, "doctorId": doctorId});
    socket.on("previousMessages", (data) {
      debugPrint("Previous messages: $data");
    });
  }

  // ** Send Message via Socket.IO **
  void sendMessageViaSocket(String chatId, String senderId, String senderModel, String text) {
    socket.emit("sendMessage", {
      "chatId": chatId,
      "senderId": senderId,
      "senderModel": senderModel,
      "text": text,
    });
  }

  // ** Listen for New Messages **
  void listenForNewMessages(Function(dynamic) onMessageReceived) {
    socket.on("newMessage", (data) {
      debugPrint("New message received: $data");
      onMessageReceived(data);
    });
  }

  // ** Disconnect Socket **
  void disconnectSocket() {
    socket.disconnect();
    debugPrint("Socket disconnected.");
  }
}
