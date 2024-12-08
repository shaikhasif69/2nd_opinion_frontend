import 'package:flutter/material.dart';

// String ip = "https://doctor-hub-six.vercel.app/api";

String ip = "http://192.168.16.46:3001/api";
String chatIp = "http://192.168.16.46:3001/";

Color ourPrimary = const Color.fromARGB(255, 3, 190, 150);

class MyColors {
  static Color ourPrimary = const Color.fromARGB(255, 3, 190, 150);

  static Color backgroundColor2 = const Color(0xFF17203A);
  static Color backgroundColorLight = const Color(0xFFF2F6FF);
  static Color backgroundColorDark = const Color(0xFF25254B);
  static Color shadowColorLight = const Color(0xFF4A5367);
  static Color lightGreen = const Color.fromARGB(255, 235, 255, 251);
  static Color shadowColorDark = Colors.black;

  static Color sideMenuColor = const Color(0xFF29435C);

  static Color secondPrimary = const Color.fromARGB(255, 3, 190, 150);
}

class Commands {
  static String hiveBuilder = "flutter packages pub run build_runner build";
}
