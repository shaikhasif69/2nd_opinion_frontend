import 'package:doctor_opinion/services/doctor/Registeration.dart';
import 'package:flutter/material.dart';

class Phonewidget extends StatefulWidget {
  const Phonewidget(
      {required TextEditingController this.con,
      required Function this.validatePhone});
  final TextEditingController con;
  final Function validatePhone;
  @override
  State<StatefulWidget> createState() {
    return _UserNameWidget();
    throw UnimplementedError();
  }
}

class _UserNameWidget extends State<Phonewidget> {
  String _phone = "";
  bool _Vphone = false;
  Widget? status = null;
  String? erro = null;

  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        controller: widget.con,
        onChanged: (phone) async {
          if (phone.isEmpty) {
            erro = null;
            setState(() {});
            return;
          }
          if (phone.length < 10 || phone.length > 10) {
            erro = "invalid number";
            setState(() {});
            return;
          }

          erro = null;
          setState(() {
            status = CircularProgressIndicator();
          });
          bool res = await DoctorRegisterationApi.validatePhone(phone);
          print("resss");
          print(res);
          if (res == true) {
            setState(() {
              status = Icon(Icons.check);
              _Vphone = res;
              widget.validatePhone(phone, res);
            });
          } else {
            setState(() {
              status = Icon(Icons.close);
              erro = "Number Already Exist";
              _Vphone = res;

              widget.validatePhone(phone, res);
            });
          }
        },
        decoration: InputDecoration(
            errorText: erro, label: const Text("Phone"), suffix: status),
      ),
    );
  }
}
