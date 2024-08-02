import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({
    super.key,
    required this.press,
    required this.riveOnInit,
  });

  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: EdgeInsets.only(left: 16),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 3, 190, 150),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 3), blurRadius: 8),
              ]),
          child: RiveAnimation.asset(
            "assets/RiveAssets/icons.riv",
            artboard: "SETTINGS",
            onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
}
