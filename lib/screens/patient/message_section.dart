import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/screens/views/chat_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  MySliverPersistentHeaderDelegate({
    required this.child,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent ||
        (oldDelegate as MySliverPersistentHeaderDelegate).child != child;
  }
}

class MessageAndConsultationSection extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MessageAndConsultationSection();
    throw UnimplementedError();
  }
}

class _MessageAndConsultationSection
    extends ConsumerState<MessageAndConsultationSection> {
  Widget build(context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 248, 241),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                backgroundColor: Color.fromARGB(255, 250, 248, 241),
                leading: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    icon: Icon(Icons.group),
                    onPressed: () {
                      // GoRouter.of(context)
                      //     .pushNamed(StudentsRoutes.StudentFourm);
                    },
                  ),
                ),
                actions: [
                  Card(
                      child: IconButton(
                          iconSize: 30,
                          onPressed: () {
                            // GoRouter.of(context)
                            //     .pushNamed(StudentsRoutes.createCommunity);
                          },
                          icon: Icon(Icons.add))),
                  Card(
                      child: IconButton(
                          iconSize: 30,
                          onPressed: () {
                            // GoRouter.of(context)
                            //     .pushNamed(StudentsRoutes.chattingList);
                          },
                          icon: Icon(Icons.notifications_outlined)))
                ],
              ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: MySliverPersistentHeaderDelegate(
                      child: Container(
                        color: Color.fromARGB(255, 250, 248, 241),
                        height: 166,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: SizedBox(
                            height: 166,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Messages",
                                    style: GoogleFonts.mulish(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Text("Get  advice, ask questions",
                                    style: GoogleFonts.mulish(
                                      color: Color.fromARGB(255, 124, 124, 124),
                                      fontSize: 16,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                TabBar(
                                  tabAlignment: TabAlignment.start,
                                  isScrollable: true,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  dividerColor: Colors.transparent,
                                  indicator: BoxDecoration(
                                    color: MyColors.ourPrimary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  labelColor: Colors.white,
                                  labelStyle: GoogleFonts.mulish(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                  unselectedLabelColor: Colors.black54,
                                  tabs: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2))),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Text(
                                          "🚀 Messages",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "☝️ Consultations",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      minHeight: 166,
                      maxHeight: 166))
            ];
          },
          body: TabBarView(
            children: [
              ChatListScreen(),
              // CommunityTab1(), Communitytab2()
            ],
          ),
        ),
      ),
    );
  }
}
