import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/services/doctorServices.dart';
import 'package:flutter/material.dart';

class UserNameWidget extends StatefulWidget {
  const UserNameWidget({
    required this.con,
    required this.vadliateUsername,
  });

  final TextEditingController con;
  final Function vadliateUsername;

  @override
  State<StatefulWidget> createState() {
    return _UserNameWidget();
  }
}

class _UserNameWidget extends State<UserNameWidget> {
  String _username = "";
  bool _vusername = false;
  Widget? status = null;
  String? error = null;
  bool isLable = true;
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
            border: showBorder
                ? Border.all(width: 2, color: ourPrimary)
                : Border.all(width: 0, color: ourPrimary)),
        child: Stack(
          children: [
            TextFormField(
              controller: widget.con,
              focusNode: _focusNode,
              onChanged: (username) async {
                username = username.trim();
                var len = widget.con.text;
                if (len.isNotEmpty) {
                  setState(() {
                    isLable = false;
                  });
                } else {
                  setState(() {
                    isLable = true;
                  });
                }
                if (username.isEmpty) {
                  setState(() {
                    error = null;
                    status = null;
                  });
                  widget.vadliateUsername(username, false);
                  return;
                }
                setState(() {
                  status = CircularProgressIndicator();
                });
                bool res =
                    await DoctorServices.validateUsername(username);
                if (res) {
                  setState(() {
                    status = Icon(Icons.check);
                    error = null;
                    _vusername = res;
                    widget.vadliateUsername(username, res);
                  });
                } else {
                  setState(() {
                    status = Icon(Icons.close);
                    error = "Username already exists";
                    _vusername = res;
                    widget.vadliateUsername(username, res);
                  });
                }
              },
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.none,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 60, right: 40),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: error != null ? Icon(Icons.close) : status,
                  ),
                ),
                suffixIconColor: ourPrimary,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Icon(Icons.account_box_outlined),
                  ),
                ),
                prefixIconColor: ourPrimary,
                focusedBorder: InputBorder.none,
                focusColor: Colors.black26,
                fillColor: Colors.transparent,
                filled: true,
                enabledBorder: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            Positioned(
              left: 40,
              top: 12,
              child: Text(
                isLable ? "Username" : "",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
