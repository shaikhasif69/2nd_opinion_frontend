import 'package:doctor_opinion/services/doctor/Registeration.dart';
import 'package:flutter/material.dart';

class UserNameWidget extends StatefulWidget {
  UserNameWidget(
      {required TextEditingController this.con,
      required Function this.vadliateUsername});
  final TextEditingController con;
  final Function vadliateUsername;
  @override
  State<StatefulWidget> createState() {
    return _UserNameWidget();
    throw UnimplementedError();
  }
}

class _UserNameWidget extends State<UserNameWidget> {
  String _username = "";
  bool _vusername = false;
  Widget? status = null;
  String? error = null;
  // final _controller = TextEditingController();
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: widget.con,
        onChanged: (username) async {
          username = username.trim();
          if (username.isEmpty) {
            error = null;
            status = null;
            widget.vadliateUsername(username, false);
            setState(() {});
            return;
          }
          if (username.isNotEmpty) {
            _username = username;
            setState(() {
              status = CircularProgressIndicator();
            });
            bool res = await DoctorRegisterationApi.validateUsername(username);
            print(res);
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
                error = "username already exist";
                _vusername = res;

                widget.vadliateUsername(username, res);
              });
            }
          }
        },
        decoration: InputDecoration(
            errorText: error, label: const Text("username"), suffix: status),
      ),
    );
  }
}
