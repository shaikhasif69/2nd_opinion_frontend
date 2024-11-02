import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static IO.Socket? _socket;

  static void connect() {
    _socket = IO.io('http://192.168.0.101:3000', IO.OptionBuilder()
      .setTransports(['websocket'])
      .build());

    _socket?.onConnect((_) {
      print('Connected to socket server');
    });

    _socket?.on('newMessage', (data) {
    });

    _socket?.onDisconnect((_) {
      print('Disconnected from socket server');
    });
  }

  static void sendMessage(String chatId, String senderId, String senderModel, String text) {
    _socket?.emit('sendMessage', {
      'chatId': chatId,
      'senderId': senderId,
      'senderModel': senderModel,
      'text': text,
    });
  }

  static IO.Socket? get socket => _socket;
}
