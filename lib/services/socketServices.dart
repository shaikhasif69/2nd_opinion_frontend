import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/services/chat_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketConnection {
  static final String serverUrl = chatIp;
  late IO.Socket socket;

  void initializeSocket() {
    socket = IO.io(
      serverUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
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

  void joinChatRoom(String userId, String doctorId) {
    print("Preparing to join chat...");

    if (socket == null || !socket.connected) {
      print("Socket not connected, initializing...");
      initializeSocket();
      socket.on('connect', (_) {
        print("Socket connected, emitting joinChat...");
        _emitJoinChat(userId, doctorId);
      });
    } else {
      _emitJoinChat(userId, doctorId);
    }
  }

  void _emitJoinChat(String userId, String doctorId) {
    if (userId.isEmpty || doctorId.isEmpty) {
      print("Empty userId or doctorId. Not sending socket events.");
      return;
    }

    print("Emitting joinChat with userId: $userId, doctorId: $doctorId");
    socket.emit("joinChat", {"userId": userId, "doctorId": doctorId});

    socket.on("previousMessages", (data) {
      print("Previous messages received: $data");
      if (data != null && data['chatId'] != null) {
        ChatSessionManager().setChatId(data['chatId']);  
      }
    });
  }

  void sendMessage(
      String chatId, String senderId, String senderModel, String text) {
    socket.emit("sendMessage", {
      "chatId": chatId,
      "senderId": senderId,
      "senderModel": senderModel,
      "text": text,
    });
  }

  void listenForNewMessages(Function(dynamic) onMessageReceived) {
    socket.on("newMessage", (data) {
      debugPrint("New message received: $data");
      onMessageReceived(data);
    });
  }

  void requestFileSharing(String userId, String doctorId) {
    socket.emit("requestFileSharing", {
      "userId": userId,
      "doctorId": doctorId,
    });

    socket.on("fileSharingRequest", (data) {
      debugPrint("File sharing request received: $data");
    });
  }

  void disconnectSocket() {
    socket.disconnect();
    debugPrint("Socket disconnected.");
  }

  // Dispose of the socket to release resources
  void disposeSocket() {
    socket.dispose();
    debugPrint("Socket disposed.");
  }
}

// Singleton pattern for easier access
final SocketConnection socketConnection = SocketConnection();
