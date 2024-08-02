import 'package:doctor_opinion/screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[Container()],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                splashRadius: 30,
                icon: Icon(Icons.child_care),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (contex) => LoginPage()));
                },
              ),
              Container(
                //width: MediaQuery.of(context).size.width/1.3,
                alignment: Alignment.center,
                child: Text(
                  "Shaikh Bhai",
                  style: GoogleFonts.lato(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                width: 55,
              ),
              IconButton(
                splashRadius: 20,
                icon: Icon(Icons.notifications_active),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (contex) => LoginPage()));
                },
              ),
            ],
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),

      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      IconButton(
                        splashRadius: 30,
                        iconSize: 30,
                        color: Theme.of(context).disabledColor,
                        icon: Icon(Icons.search_rounded),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => LoginPage()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      children: [
                        Image.asset("assets/doctor.jpeg"),
                        const Text("Dr. Rajkumat")
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      )),
    );
  }
}
