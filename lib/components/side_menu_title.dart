import 'package:doctor_opinion/components/info_card.dart';
import 'package:doctor_opinion/models/rive_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SideMenuTitle extends StatelessWidget {
  const SideMenuTitle({
    super.key,
    required this.menu,
    required this.press,
    required this.riveonInit,
    required this.isActive,
  });

  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24, top: 1, bottom: 1),
          child: Divider(
            height: 1,
            color: Colors.white70,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              height: 56,
              curve: Curves.fastOutSlowIn,
              left: 0,
              width: isActive ? MediaQuery.of(context).size.width / 1.3 : 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            ListTile(
                onTap: press,
                leading: SizedBox(
                  height: MediaQuery.of(context).size.width / 11,
                  width: 50,
                  child: RiveAnimation.asset(
                    menu.src,
                    artboard: menu.artboard,
                    onInit: riveonInit,
                  ),
                ),
                title: Text(
                  menu.title,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
          ],
        ),
      ],
    );
  }
}
