import 'package:doctor_opinion/models/all_messages_model.dart';
import 'package:doctor_opinion/models/hiveModels/user.dart';
import 'package:doctor_opinion/provider/all_msg_provider.dart';
import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:doctor_opinion/services/hiveServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await getUserId();
      if (userId != null) {
        final messageNotifier = ref.read(messageProvider.notifier);
        final messageState = ref.read(messageProvider);

        if (messageState.messages == null || messageState.messages!.isEmpty) {
          messageNotifier.fetchAllMessages(userId!);
        }
      }
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

  @override
  Widget build(BuildContext context) {
    final messageState = ref.watch(messageProvider);

    return Scaffold(
      body: messageState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : messageState.error != null
              ? Center(
                  child: Text(
                    "Error: ${messageState.error}",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  itemCount: messageState.messages?.length ?? 0,
                  itemBuilder: (context, index) {
                    final chat = messageState.messages![index];
                    return GestureDetector(
                      onTap: () {
                        // TODO: Implement logic for chat screen navigation
                      },
                      child: GestureDetector(
                          onTap: () {
                            print("tapnig nmber: " + index.toString());
                            GoRouter.of(context).pushNamed(PatientRoutes.chatDoctorScreen,
                             pathParameters: {
                                "docId": chat.id,
                                "docFirstName": chat.firstName,
                                "docSecondName": chat.lastName,
                                "docProfilePic": chat.profilePicture
                              });
                          },
                          child: ChatListTile(chat: chat)),
                    );
                  },
                ),
    );
  }
}

class ChatListTile extends StatelessWidget {
  final AllMessagesModel chat;

  const ChatListTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(chat.profilePicture),
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${chat.firstName} ${chat.lastName}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  chat.lastMessage ?? "No messages yet",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
