import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.proffesion,
  });

  final String name, proffesion;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
          size: 35,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      subtitle: Text(
        proffesion,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
