import 'dart:ffi';
import 'dart:math';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:doctor_opinion/components/menu_bar.dart';
import 'package:doctor_opinion/components/rive_utils.dart';
import 'package:doctor_opinion/components/side_menu.dart';
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

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;
  late var isSideBar;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            setState(() {});
          });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool isSideBarClosed = true;
  List<IconData> icons = [
    FontAwesomeIcons.home,
    FontAwesomeIcons.envelope,
    FontAwesomeIcons.clipboardCheck,
    FontAwesomeIcons.user,
  ];

  int page = 0;

  @override
  Widget build(BuildContext context) {
    var sideBarWidth = MediaQuery.of(context).size.width / 1.35;

    List<Widget> pages = [
      Stack(children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          width: sideBarWidth,
          left: isSideBarClosed ? -(MediaQuery.of(context).size.width / 1) : 0,
          height: MediaQuery.of(context).size.height,
          child: SideMenu(),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value - 30 * animation.value * pi / 180),
          child: Transform.translate(
            offset: Offset(
                animation.value * MediaQuery.of(context).size.width / 1.44, 0),
            child: Transform.scale(
              scale: isSideBarClosed ? 1 : 0.87,
              // scale: scalAnimation.value,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft:
                          isSideBarClosed ? Radius.zero : Radius.circular(30)),
                  child: Dashboard()),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          left: isSideBarClosed ? 0: MediaQuery.of(context).size.width / 1.8,
          top: 16,
          curve: Curves.fastOutSlowIn,
          child: MenuBtn(
            riveOnInit: (artboard) {
              try {
                StateMachineController controller = RiveUtils.getRiveController(
                    artboard,
                    stateMachineName: "SETTINGS_Interactivity");
                var input = controller.findSMI("active");
                if (input != null && input is SMIBool) {
                  input = input;
                  isSideBar = input;
                  isSideBar.value = false;
                } else {
                  throw Exception('SMIBool not found for name: active');
                }
              } catch (e) {
                print('Error initializing Rive: $e');
              }
            },
            press: () {
              isSideBar.value = !isSideBar.value;
              Future.delayed(const Duration(seconds: 1), () {
                isSideBar.change(false);
              });
              if (isSideBarClosed) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
              setState(() {
                isSideBarClosed = !isSideBarClosed;
              });
            },
          ),
        )
      ]),
      message_tab_all(),
      shedule_screen(),
      Profile_screen()
    ];

    return Scaffold(
      backgroundColor: Colors.blueGrey,
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
