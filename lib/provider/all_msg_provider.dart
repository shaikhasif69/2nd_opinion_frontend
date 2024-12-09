import 'package:doctor_opinion/models/all_messages_model.dart';
import 'package:doctor_opinion/services/all_message_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageState {
  final bool isLoading;
  final List<AllMessagesModel>? messages;
  final String? error;

  MessageState({
    required this.isLoading,
    this.messages,
    this.error,
  });

  MessageState copyWith({
    bool? isLoading,
    List<AllMessagesModel>? messages,
    String? error,
  }) {
    return MessageState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
      error: error ?? this.error,
    );
  }
}

class MessageNotifier extends StateNotifier<MessageState> {
  final MessageService messageService;

  MessageNotifier(this.messageService) : super(MessageState(isLoading: false));

  Future<void> fetchAllMessages(String userId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final messages = await messageService.fetchAllMessages(userId);
      state = state.copyWith(isLoading: false, messages: messages);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Define the provider
final messageProvider = StateNotifierProvider<MessageNotifier, MessageState>(
  (ref) => MessageNotifier(MessageService()),
);
