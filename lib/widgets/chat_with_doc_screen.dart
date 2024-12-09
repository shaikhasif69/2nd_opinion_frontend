import 'package:doctor_opinion/models/doctor/Doctor.dart';
import 'package:doctor_opinion/models/hiveModels/user.dart';
import 'package:doctor_opinion/services/chat_session_manager.dart';
import 'package:doctor_opinion/services/hiveServices.dart';
import 'package:doctor_opinion/services/socketServices.dart';
import 'package:doctor_opinion/widgets/chat_doctor_profile_widget.dart';
import 'package:doctor_opinion/widgets/chat_info.dart';
import 'package:flutter/material.dart';
import 'package:doctor_opinion/models/flutter_chat_types.dart' as types;

class ChatWithDocScreen extends StatefulWidget {
  // final DoctorClass doctor;
  String docId; 
    String docFirstName;
  String docSecName;
  String docProfilePic;


  ChatWithDocScreen({required this.docId, required this.docFirstName, required this.docProfilePic, required this.docSecName, Key? key}) : super(key: key);

  @override
  State<ChatWithDocScreen> createState() => _ChatWithDocScreenState();
}

enum CustomRole { user, doctor }

class _ChatWithDocScreenState extends State<ChatWithDocScreen> {
  final List<types.TextMessage> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  String? _chatId;
  String userId = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await getUserId();
    await waitForSocketAndRoom();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getUserId() async {
    final hiveService = HiveService();
    HiveUser? user = await hiveService.getUser();
    if (user != null) {
      setState(() {
        userId = user.id;
      });
    }
  }

  Future<void> waitForSocketAndRoom() async {
    if (userId.isEmpty) {
      print("Waiting for userId...");
      await Future.delayed(const Duration(milliseconds: 100));
    }

    print("Joining chat room...");
    socketConnection.joinChatRoom(userId, widget.docId);

    while (ChatSessionManager().chatId == null) {
      print("Waiting for chatId to be set...");
      await Future.delayed(const Duration(milliseconds: 100));
    }

    setState(() {
      _chatId = ChatSessionManager().chatId;
    });

    initializeSocketListeners();
  }

  void initializeSocketListeners() {
    if (_chatId == null) {
      print("Cannot initialize listeners without valid chatId");
      return;
    }

    socketConnection.listenForNewMessages((data) {
      print("Received new message: $data");
      setState(() {
        _messages.insert(
          0,
          types.TextMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            author: types.User(
              id: data["senderId"],
              role: types.mapStringToRole(data["senderRole"]),  
            ),
            text: data["text"],
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
      });
    });

    socketConnection.socket.on("previousMessages", (data) {
      print("Previous messages received: $data");
      if (data != null && data["messages"] is List) {
        List<types.TextMessage> parsedMessages = (data["messages"] as List)
            .map(
              (msg) => types.TextMessage(
                id: msg["_id"],
                author: types.User(
                  id: msg["sender"],
                  role: types.mapStringToRole(msg["senderModel"]) ?? types.Role.user,
                ),
                text: msg["text"],
                createdAt:
                    DateTime.parse(msg["timestamp"]).millisecondsSinceEpoch,
              ),
            )
            .toList();

        setState(() {
          _messages.clear();
          _messages
              .addAll(parsedMessages); // Maintain chronological order
        });
      }

      // Save chatId if it's part of the response
      if (data != null && data['chatId'] != null) {
        ChatSessionManager().setChatId(data['chatId']);
      }
    });
  }

  void sendMessage() {
    if (_chatId == null) {
      print("Cannot send message yet. Chat ID is not initialized.");
      return;
    }

    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      socketConnection.sendMessage(
        _chatId!,
        userId,
        "User",
        text,
      );

      final newMessage = types.TextMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        author: types.User(id: userId, role: types.Role.user),
        text: text,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      setState(() {
        _messages.add(newMessage);
        _messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    socketConnection.disconnectSocket();
    super.dispose();
  }

  Widget _buildMessageList() {
    return Expanded(
  child: ListView.builder(
    itemCount: _messages.length,
    itemBuilder: (context, index) {
      final message = _messages[index];
      final isMe = message.author.id == userId;
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 14,
          ),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue[200] : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message.text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      );
    },
  ),
);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        // Leading icon for navigation
        leading: GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     PageTransition(
            //         type: PageTransitionType.fade, child: Homepage()));
          },
          child: Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("lib/icons/back1.png"),
            )),
          ),
        ),
        // title: Text(
        //   widget.doctor.firstName + " " + widget.doctor.lastName,
        //   style: GoogleFonts.poppins(
        //       color: Colors.black,
        //       fontWeight: FontWeight.w500,
        //       fontSize: 17.sp),
        // ),
        title: chat_doctor_profile_widget(
          docFirstName: widget.docFirstName,
          docSecName: widget.docSecName,
          docProfilePic: widget.docProfilePic,
        ),
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 60,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  height: 18,
                  width: 18,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("lib/icons/video_call.png"),
                  )),
                ),
                const SizedBox(
                  width: 15,
                ),
                // Call icon
                Container(
                  height: 18,
                  width: 18,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("lib/icons/call.png"),
                  )),
                ),
                const SizedBox(
                  width: 15,
                ),
                // More options icon
                Container(
                  height: 18,
                  width: 18,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("lib/icons/more.png"),
                  )),
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const chat_info(),
          const SizedBox(
            height: 30,
          ),
          _buildMessageList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
 
}

class User {
  final String id;
  final String role; // "User" or "Doctor"

  User({required this.id, required this.role});
}
