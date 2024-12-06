import 'package:doctor_opinion/models/hiveModels/user.dart';
import 'package:doctor_opinion/services/chat_service.dart';
import 'package:doctor_opinion/services/hiveServices.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final dynamic doctor;

  const ChatScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  late IO.Socket _socket;
  String? _chatId;
  List<dynamic> _messages = [];
  late String userId;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }


  Future<void> getUserDetails() async {
    final hiveService = HiveService();
    HiveUser? user = await hiveService.getUser();

    if (user != null) {
      print('User ID: ${user.id}');
      print('User Name: ${user.firstName} ${user.lastName}');
      setState(() {
       userId = user.id;
      });
    }
  }

  @override
  void dispose() {
    _socket.disconnect();
    super.dispose();
  }

  Future<void> _initializeChat() async {
    // Initialize chat via API
    final chatData = await _chatService.getOrCreateChat(
      userId, 
      widget.doctor.id,
    );

    if (chatData != null) {
      setState(() {
        _chatId = chatData["chatId"];
        _messages = chatData["messages"];
      });

      // Initialize WebSocket connection
      _chatService.initSocketConnection();
      _socket = _chatService.socket;

      // Join the chat room
      _chatService.joinChatRoom(userId, widget.doctor.id);

      // Listen for new messages
      _chatService.listenForNewMessages((message) {
        setState(() {
          _messages.add(message);
        });
      });
    }
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final messageText = _messageController.text.trim();
    _messageController.clear();

    // Send message via API
    if (_chatId != null) {
      final message = await _chatService.sendMessage(
        _chatId!,
        userId, // Replace with actual user ID
        "User", // Sender model
        messageText,
      );

      if (message != null) {
        // Send message via WebSocket
        _chatService.sendMessageViaSocket(
          _chatId!,
          userId,
          "User",
          messageText,
        );

        // Add message to the local UI
        setState(() {
          _messages.add(message);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          "${widget.doctor.firstName} ${widget.doctor.lastName}",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMine = message["senderId"] == userId; // Replace with actual user ID

                return Align(
                  alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isMine ? Colors.green[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message["text"]),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
