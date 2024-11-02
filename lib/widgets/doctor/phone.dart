import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/services/doctorServices.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Phonewidget extends StatefulWidget {
  const Phonewidget({
    required this.con,
    required this.validatePhone,
  });

  final TextEditingController con;
  final Function validatePhone;

  @override
  State<StatefulWidget> createState() {
    return _Phonewidget();
  }
}

class _Phonewidget extends State<Phonewidget> {
  String _phone = "";
  bool _Vphone = false;
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
            border: showBorder
                ? Border.all(width: 2, color: ourPrimary)
                : Border.all(width: 0, color: ourPrimary)),
        child: Stack(
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: widget.con,
              focusNode: _focusNode,
              onChanged: (phone) async {
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

                if (phone.isEmpty) {
                  setState(() {
                    erro = null;
                    status = null;
                  });
                  return;
                }
                if (phone.length != 10) {
                  setState(() {
                    erro = "Invalid number";
                    status = null;
                  });
                  return;
                }

                // if(phone.length > 1){
                //   print("hello!");
                //   isLable = !isLable;
                // }
                setState(() {
                  erro = null;
                  status = CircularProgressIndicator();
                });

                bool res = await DoctorServices.validatePhone(phone);
                if (res == true) {
                  setState(() {
                    status = Icon(Icons.check);
                    _Vphone = res;
                    widget.validatePhone(phone, res);
                  });
                } else {
                  setState(() {
                    status = Icon(Icons.close);
                    erro = "Number already exists";
                    _Vphone = res;
                    widget.validatePhone(phone, res);
                  });
                }
              },
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.none,
              obscureText: false,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 60, right: 40),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: erro != null ? Icon(Icons.close) : status,
                  ),
                ),
                suffixIconColor: const Color.fromARGB(255, 3, 190, 150),
                prefixIcon: Icon(Icons.phone),
                prefixIconColor: const Color.fromARGB(255, 3, 190, 150),
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
                //  isLable?
                isLable ? "Phone" : "",
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
