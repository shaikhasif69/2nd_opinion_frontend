import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:doctor_opinion/components/menu_bar.dart';
import 'package:doctor_opinion/components/rive_utils.dart';
import 'package:doctor_opinion/screens/patient/Dashboard_screen.dart';
import 'package:doctor_opinion/screens/patient/Profile_screen.dart';
import 'package:doctor_opinion/screens/patient/shedule_screen.dart';
import 'package:doctor_opinion/widgets/TabbarPages/message_tab_all.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late SMIBool isMenuOpen;

  List<IconData> icons = [
    FontAwesomeIcons.home,
    FontAwesomeIcons.envelope,
    FontAwesomeIcons.clipboardCheck,
    FontAwesomeIcons.user,
  ];

  int page = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Stack(children: [
        Dashboard(),
        MenuBtn(
          riveOnInit: (artboard) {
            StateMachineController controller = RiveUtils.getRiveController(
                artboard,
                stateMachineName: "switch");
            isMenuOpen = controller.findSMI("toOpen") as SMIBool;
          },
          press: () {
            isMenuOpen.value = !isMenuOpen.value;
          },
        )
      ]),
      message_tab_all(),
      shedule_screen(),
      Profile_screen()
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[page],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: icons,
        iconSize: 25,
        activeIndex: page,
        height: 65,
        splashSpeedInMilliseconds: 300,
        gapLocation: GapLocation.none,
        activeColor: const Color.fromARGB(255, 0, 190, 165),
        inactiveColor: const Color.fromARGB(255, 223, 219, 219),
        onTap: (int tappedIndex) {
          setState(() {
            page = tappedIndex;
          });
        },
      ),
    );
  }
}
