import 'package:doctor_opinion/components/constant.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final String icon;
  AuthTextField({
    required this.controller,
    required this.text,
    required this.icon,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool showBorder = false;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        showBorder = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 247, 247, 247),
          borderRadius: BorderRadius.circular(30),
          border: showBorder ? Border.all(width: 2, color: ourPrimary) : Border.all(width: 0, color: ourPrimary)
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.none,
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            focusColor: Colors.black26,
            fillColor: Colors.transparent,
            filled: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                child: Image.asset(widget.icon, color: Color.fromARGB(255, 3, 190, 150)),
              ),
            ),
            prefixIconColor: const Color.fromARGB(255, 3, 190, 150),
            label: Text(widget.text),
            enabledBorder: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ),
    );
  }
}
