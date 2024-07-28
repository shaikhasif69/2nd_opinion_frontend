import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      // Positioned(
                      //   left: 30,
                      //   width: 80,
                      //   height: 200,
                      //   child: FadeInUp(
                      //       duration: Duration(seconds: 1),
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: AssetImage(
                      //                     'assets/images/light-1.png'))),
                      //       )),
                      // ),
                      // Positioned(
                      //   left: 140,
                      //   width: 80,
                      //   height: 150,
                      //   child: FadeInUp(
                      //       duration: Duration(milliseconds: 1200),
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: AssetImage(
                      //                     'assets/images/light-2.png'))),
                      //       )),
                      // ),
                      // Positioned(
                      //   right: 40,
                      //   top: 40,
                      //   width: 80,
                      //   height: 150,
                      //   child: FadeInUp(
                      //       duration: Duration(milliseconds: 1300),
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: AssetImage(
                      //                     'assets/images/clock.png'))),
                      //       )),
                      // ),
                      Positioned(
                        child: FadeInUp(
                            duration: Duration(milliseconds: 1600),
                            child: Container(
                              margin: EdgeInsets.only(top: 50),
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Form(
                    key: _fromkey,
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                            duration: Duration(milliseconds: 1800),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                  boxShadow: [
                                    const BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    143, 148, 251, 1)))),
                                    child: TextFormField(
                                      onChanged: (data) {},
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "username cannot be empty";
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email or Phone number",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[700])),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      obscureText: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Password cannot be empty";
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[700])),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_fromkey.currentState!.validate()) {}
                          },
                          child: FadeInUp(
                              duration: const Duration(milliseconds: 1900),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ),
                        Row(
                          children: [
                            FadeInUp(
                                duration: const Duration(milliseconds: 2000),
                                child: TextButton(
                                  child: const Text("Forgot Password?",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              143, 148, 251, 1))),
                                  onPressed: () {},
                                )),
                            const Spacer(),
                            FadeInUp(
                                duration: const Duration(milliseconds: 2000),
                                child: TextButton(
                                  child: const Text("sign up",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              143, 148, 251, 1))),
                                  onPressed: () {
                                    _showSignUpRoleDialog(context);
                                  },
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  int selected = 0;
  void _showSignUpRoleDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (c) {
          return StatefulBuilder(builder: (c, setState) {
            return AlertDialog(
              title: SingleChildScrollView(
                child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Join us as ?",
                            style: Theme.of(context).primaryTextTheme.bodyLarge,
                          ),
                        ))),
              ),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = 0;
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(c).size.width * 0.7,
                            width: MediaQuery.of(c).size.width * 0.3,
                            decoration: selected == 0
                                ? BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    borderRadius: BorderRadius.circular(10))
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Card(
                                  elevation: 10,
                                  child: SizedBox(
                                    // height: MediaQuery.of(c).size.height * 0.3,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Image.asset(
                                            "assets/25872124_doctor_consultation_03 Background Removed.png",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Doctor",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Docors are very good at works .they should work",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            maxLines: 4,
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = 1;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(c).size.width * 0.3,
                            height: MediaQuery.of(c).size.width * 0.7,
                            decoration: selected == 1
                                ? BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    borderRadius: BorderRadius.circular(10))
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Card(
                                  elevation: 10,
                                  child: SizedBox(
                                    // height: MediaQuery.of(c).size.height * 0.3,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Image.asset(
                                            "assets/25872124_doctor_consultation_03 Background Removed.png",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Patient",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Patient can uploa reports to scan",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            maxLines: 4,
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (selected == 0) {
                              GoRouter.of(context)
                                  .pushNamed(DoctorRoutes.signUp);
                            }
                          },
                          child: const Text("Sign up")),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
