import 'package:doctor_opinion/components/constant.dart';
import 'package:flutter/material.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColorLight,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
          Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.9,
           decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 241, 234, 234),
        ),
            child: TextField(
              // onTap: () {
              //   Navigator.push(
              //       context,
              //       PageTransition(
              //           type: PageTransitionType.rightToLeft,
              //           child: find_doctor()));
              // },
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.none,
              autofocus: false,
              obscureText: false,
              keyboardType: TextInputType.name,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                focusColor: Colors.black26,
                fillColor: Colors.transparent,
                filled: true,
                focusedBorder: InputBorder.none,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                    height: 10,
                    width: 10,
                    child: Image.asset(
                      "lib/icons/search.png",
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                prefixIconColor: const Color.fromARGB(255, 3, 190, 150),
                label: Text("Search doctor, drugs, articles..."),
                enabledBorder: InputBorder.none,
    
                floatingLabelBehavior: FloatingLabelBehavior.never,
           
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}