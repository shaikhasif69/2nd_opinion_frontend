import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/services/chatServices.dart';
import 'package:doctor_opinion/services/socketServices.dart';
import 'package:doctor_opinion/widgets/chat_screen.dart';
import 'package:doctor_opinion/widgets/message_all_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:developer' as dev;
import 'package:intl/intl.dart';

class D_chatPage extends StatefulWidget {
  final String doctorId;

  const D_chatPage({Key? key, required this.doctorId}) : super(key: key);

  @override
  _D_chatPageState createState() => _D_chatPageState();
}

class _D_chatPageState extends State<D_chatPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    chats = ChatService().fetchChatsForDoctor(widget.doctorId);
    SocketService.connect();

    SocketService.socket?.on('newMessage', (data) {
      setState(() {
        chats = ChatService().fetchChatsForDoctor(widget.doctorId);
        // Alternatively, you can directly update the chat list with the new message data
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    SocketService.socket?.disconnect();
    super.dispose();
  }

  late Future<List<Map<String, dynamic>>> chats;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColorLight,
      appBar: AppBar(
        title: Text(
          "Chats",
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 18.sp),
        ),
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/icons/bell.png"),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: MyColors.backgroundColorLight,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 235, 235, 235)),
                color: MyColors.lightGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Color.fromARGB(255, 5, 185, 155),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  indicatorColor: const Color.fromARGB(255, 241, 241, 241),
                  unselectedLabelColor: const Color.fromARGB(255, 32, 32, 32),
                  labelColor: Color.fromARGB(255, 255, 255, 255),
                  controller: tabController,
                  tabs: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Tab(
                        text: "Accepted",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Tab(
                        text: "Pending",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Tab(
                        text: "Rejected",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            // <-- Add Expanded here
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: chats,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No chats available'));
                } else {
                  final chatList = snapshot.data!;
                  return ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      final chat = chatList[index];
                      final latestMessage = chat['latestMessage'];
                      final mostRecentText = latestMessage != null
                          ? latestMessage['text'] ?? 'No message'
                          : 'No message';
                      final mostRecentTimestamp = latestMessage != null
                          ? latestMessage['timestamp'] != null
                              ? DateFormat('HH:mm').format(
                                  DateTime.parse(latestMessage['timestamp'])
                                      .toLocal())
                              : '00:00'
                          : '00:00';

                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //       type: PageTransitionType.bottomToTop,
                          //       // child: Text("something here1")
                          //       child: chat_screen()
                          //       // child: ChatScreen(chatId: chat['_id']),
                          //       ),
                          // );
                        },
                        child: message_all_widget(
                          image: "lib/icons/male-doctor.png",
                          Maintext: chat['participants'].firstWhere(
                                  (participant) =>
                                      participant['_id'] != widget.doctorId,
                                  orElse: () => {
                                        'username': 'Unknown User'
                                      })['username'] ??
                              'User Name',
                          subtext: mostRecentText,
                          time: mostRecentTimestamp,
                          message_count: chat['unreadMessages'] != null
                              ? chat['unreadMessages'].toString()
                              : '0',
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
