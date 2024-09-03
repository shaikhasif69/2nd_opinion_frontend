import 'dart:math';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/components/menu_bar.dart';
import 'package:doctor_opinion/components/rive_utils.dart';
import 'package:doctor_opinion/components/side_menu.dart';
import 'package:doctor_opinion/models/hiveModels/doctor_hive.dart';
import 'package:doctor_opinion/models/menu.dart';
import 'package:doctor_opinion/models/rive_assets.dart';
import 'package:doctor_opinion/screens/doctor/chatPage.dart';
import 'package:doctor_opinion/screens/doctor/dDashboardPage.dart';
import 'package:doctor_opinion/screens/doctor/dProfilePage.dart';
import 'package:doctor_opinion/screens/doctor/dSideMenu.dart';
import 'package:doctor_opinion/screens/doctor/notificationPage.dart';
import 'package:doctor_opinion/screens/patient/Profile_screen.dart';
import 'package:doctor_opinion/screens/patient/shedule_screen.dart';
import 'package:doctor_opinion/screens/views/searchPage.dart';
import 'package:doctor_opinion/services/hiveServices.dart';
import 'package:doctor_opinion/widgets/TabbarPages/message_tab_all.dart';
import 'package:doctor_opinion/widgets/doctor/btm_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  Menu selectedBottonNav = bottomNavItems[2];
  late Animation<double> scalAnimation;
  late var isSideBar;

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }
  

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() {
            setState(() {});
          });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
    getUserDetails();

  }

 late String doctorId = "";

  Future<void> getUserDetails() async {
    final hiveService = HiveService();
    DoctorHive? doctor = await hiveService.getDoctor();

    if (doctor != null) {
      print('doctor ID: ${doctor.id}');
      print('doctor Name: ${doctor.firstName} ${doctor.lastName}');
      setState(() {
        doctorId = doctor.id;
      });
      // Use the user data as needed
    }
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

  int page = 2;
  @override
  Widget build(BuildContext context) {
    print("doc id: " + doctorId);
    var sideBarWidth = MediaQuery.of(context).size.width / 1.35;

    List<Widget> pages = [
      D_chatPage(doctorId: doctorId,),
      searchPage(),
      Stack(children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          width: sideBarWidth,
          left: isSideBarClosed ? -(MediaQuery.of(context).size.width / 1) : 0,
          height: MediaQuery.of(context).size.height,
          child: DoctorSideMenu(),
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
                      bottomLeft: isSideBarClosed
                          ? Radius.zero
                          : const Radius.circular(30)),
                  child: DoctorDashboard()),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          left: isSideBarClosed ? 0 : MediaQuery.of(context).size.width / 1.8,
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
      NotificationPage(),
      DoctorProfilePage()
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: MyColors.sideMenuColor,
      body: pages[page],
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: SafeArea(
          child: Container(
            padding:
                const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: MyColors.backgroundColor2.withOpacity(0.8),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: MyColors.backgroundColor2.withOpacity(0.3),
                  offset: const Offset(0, 20),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  bottomNavs.length,
                  (index) {
                    Menu navBar = bottomNavItems[index];
                    return BtmNavItem(
                      navBar: navBar,
                      press: () {
                        print('index: ' + index.toString());
                        RiveUtils.chnageSMIBoolState(navBar.rive.status!);
                        updateSelectedBtmNav(navBar);
                         setState(() {
                          page = index;
                        });
                      },
                      riveOnInit: (artboard) {
                        navBar.rive.status = RiveUtils.getRiveInput(artboard,
                            stateMachineName: navBar.rive.stateMachineName);
                      },
                      selectedNav: selectedBottonNav,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
