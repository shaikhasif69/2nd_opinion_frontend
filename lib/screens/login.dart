import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:doctor_opinion/screens/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_opinion/screens/forgot_pass.dart';
import 'package:doctor_opinion/Widgets/Auth_text_field.dart';
import 'package:doctor_opinion/Widgets/auth_social_login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:go_router/go_router.dart';

class login extends StatelessWidget {
  // const login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              child: Image.asset("lib/icons/back2.png")),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: login_signup()));
          },
        ),
        centerTitle: true,
        title: Text(
          "Login",
          style: GoogleFonts.inter(
              color: Colors.black87,
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0),
        ),
        toolbarHeight: 160,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            const SizedBox(
              height: 60,
            ),
            // Auth_text_field(
            //     text: "Enter you email", icon: "lib/icons/email.png"),
            // const SizedBox(
            //   height: 5,
            // ),
            // Auth_text_field(
            //     text: "Enter your password", icon: "lib/icons/lock.png"),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: forgot_pass()));
                },
                child: Text(
                  "Forgot your password?",
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: const Color.fromARGB(255, 3, 190, 150),
                      fontWeight: FontWeight.w500),
                ),
              )
            ]),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  // Perform verification or other actions here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 3, 190, 150),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    print("helllooo");
                    GoRouter.of(context).pushNamed(PatientRoutes.homePage);
                  },
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp, color: Colors.black87),
                ),
                GestureDetector(
    
                  onTap: () {
                    _showSignUpRoleDialog(context);
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: const Color.fromARGB(255, 3, 190, 150),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "or",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            auth_social_logins(
                logo: "images/google.png", text: "Sign in with Google"),
            const SizedBox(
              height: 20,
            ),
            auth_social_logins(logo: "images/apple.png", text: "Sign in Apple"),
            const SizedBox(
              height: 20,
            ),
            auth_social_logins(
                logo: "images/facebook.png", text: "Sign in facebook")
          ]),
        ),
      ),
    );
  }

  int selected = 0;
  void _showSignUpRoleDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (c) {
          return StatefulBuilder(builder: (c, setState) {
            return AlertDialog(
              title: Center(
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
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.405,
                // height: 400,
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
                            else if(selected == 1) {
                              GoRouter.of(context).pushNamed(PatientRoutes.signUp);
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
