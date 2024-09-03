import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/components/info_card.dart';
import 'package:doctor_opinion/components/rive_utils.dart';
import 'package:doctor_opinion/components/side_menu_title.dart';
import 'package:doctor_opinion/models/rive_assets.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class DoctorSideMenu extends StatefulWidget {
  const DoctorSideMenu({super.key});

  @override
  State<DoctorSideMenu> createState() => _DoctorSideMenuState();
}

class _DoctorSideMenuState extends State<DoctorSideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width / 1.35,
        height: double.infinity,
        color: MyColors.sideMenuColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const InfoCard(
                name: "Mehreen",
                proffesion: "Surgeon",
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, top: 15, bottom: 14),
                child: Text(
                  "Browse",
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                ),
              ),
              ...DsideMenus
                  .map((menu) => SideMenuTitle(
                        menu: menu,
                        riveonInit: (artboard) {
                          try {
                            StateMachineController controller =
                                RiveUtils.getRiveController(artboard,
                                    stateMachineName: menu.stateMachineName);
                            var input = controller.findSMI("active");
                            if (input != null && input is SMIBool) {
                              menu.input = input;
                            } else {
                              throw Exception(
                                  'SMIBool not found for name: active');
                            }
                          } catch (e) {
                            print('Error initializing Rive: $e');
                          }
                        },
                        press: () {
                          menu.input?.change(true);
                          Future.delayed(Duration(seconds: 1), () {
                            menu.input!.change(false);
                          });

                          setState(() {
                            selectedMenu = menu;
                          });
                        },
                        isActive: selectedMenu == menu,
                      ))
                  .toList(),
                  
              ...DsideMenus2
                  .map((menu) => SideMenuTitle(
                        menu: menu,
                        riveonInit: (artboard) {
                          try {
                            StateMachineController controller =
                                RiveUtils.getRiveController(artboard,
                                    stateMachineName: menu.stateMachineName);
                            var input = controller.findSMI("active");
                            if (input != null && input is SMIBool) {
                              menu.input = input;
                            } else {
                              throw Exception(
                                  'SMIBool not found for name: active');
                            }
                          } catch (e) {
                            print('Error initializing Rive: $e');
                          }
                        },
                        press: () {
                          menu.input?.change(true);
                          Future.delayed(Duration(seconds: 1), () {
                            menu.input!.change(false);
                          });

                          setState(() {
                            selectedMenu = menu;
                          });
                        },
                        isActive: selectedMenu == menu,
                      ))
                  .toList(),

                        const Padding(
                padding: EdgeInsets.only(left: 30, top: 15, bottom: 14),
                child: Text(
                  "Others",
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
