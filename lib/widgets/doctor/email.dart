import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/services/doctor/Registeration.dart';
import 'package:flutter/material.dart';

class EmailWidget extends StatefulWidget {
  const EmailWidget({
    required this.con,
    required this.validateEmail,
  });

  final TextEditingController con;
  final Function validateEmail;

  @override
  State<StatefulWidget> createState() {
    return _EmailWidget();
  }
}

class _EmailWidget extends State<EmailWidget> {
  String _email = "";
  bool _vemail = false;
  bool entereEmail = true;
  Widget? status = null;
  String? erro = null;
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
          border: showBorder ? Border.all(width: 2, color: ourPrimary) : Border.all(width: 0, color: ourPrimary)
        ),
        child: Stack(
          children: [
            TextFormField(
              controller: widget.con,
              focusNode: _focusNode,
              onChanged: (email) async {
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

                if (email.isEmpty) {
                  setState(() {
                    erro = null;
                    status = null;
                  });
                  return;
                }

                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email)) {
                  setState(() {
                    erro = "Enter a valid email";
                  });
                  return;
                }

                setState(() {
                  erro = null;
                  entereEmail = false;
                  status = CircularProgressIndicator();
                });

                bool res = await DoctorRegisterationApi.validateEmail(email);
                if (res == true) {
                  setState(() {
                    status = Icon(Icons.check);
                    _vemail = res;
                    widget.validateEmail(email, res);
                  });
                } else {
                  setState(() {
                    erro = "User already exists";
                    status = Icon(Icons.close);
                    _vemail = res;
                    widget.validateEmail(email, res);
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
                    child: erro != null ? Icon(Icons.close) : status,
                  ),
                ),
                suffixIconColor: ourPrimary,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Icon(Icons.email),
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
                isLable ? "Email" : "",
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
