import 'package:flutter/material.dart';

class MessageProvider with ChangeNotifier {
  List<dynamic> _messages = [];

  List<dynamic> get messages => _messages;

  void addMessage(dynamic message) {
    _messages.add(message);
    notifyListeners();
  }
}
