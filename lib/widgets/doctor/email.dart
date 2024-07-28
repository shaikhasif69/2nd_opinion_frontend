import 'package:doctor_opinion/services/doctor/Registeration.dart';
import 'package:flutter/material.dart';

class EmailWidget extends StatefulWidget {
  const EmailWidget(
      {required TextEditingController this.con,
      required Function this.validateEmail});
  final TextEditingController con;
  final Function validateEmail;
  @override
  State<StatefulWidget> createState() {
    return _EmailWidget();
    throw UnimplementedError();
  }
}

class _EmailWidget extends State<EmailWidget> {
  String _email = "";
  bool _vemail = false;
  bool entereEmail = true;
  Widget? status = null;
  String? erro = null;

  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: widget.con,
        onChanged: (email) async {
          if (email.isEmpty) {
            setState(() {});
            erro = null;
            return;
          }
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(email)) {
            setState(() {});
            erro = "Enter A valid email";
            return;
          }
          if (email.isNotEmpty) {
            erro = null;
            entereEmail = false;
            setState(() {
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
                erro = "User already exist";
                status = Icon(Icons.close);

                _vemail = res;

                widget.validateEmail(email, res);
              });
            }
          } else {
            setState(() {
              entereEmail = true;
            });
          }
        },
        decoration: InputDecoration(
            errorText: erro, label: const Text("Email"), suffix: status),
      ),
    );
  }
}
