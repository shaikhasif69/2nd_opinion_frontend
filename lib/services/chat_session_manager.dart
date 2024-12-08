class ChatSessionManager {
  static final ChatSessionManager _instance = ChatSessionManager._internal();
  String? _chatId;

  factory ChatSessionManager() {
    return _instance;
  }

  ChatSessionManager._internal();

  void setChatId(String chatId) {
    _chatId = chatId;
  }

  String? get chatId => _chatId;
}
