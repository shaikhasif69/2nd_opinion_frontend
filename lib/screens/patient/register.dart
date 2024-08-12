import 'package:doctor_opinion/screens/doctor/signup.dart';
import 'package:doctor_opinion/screens/login.dart';
import 'package:doctor_opinion/screens/loginPage.dart';
import 'package:doctor_opinion/screens/patient/userOtpForm.dart';
import 'package:doctor_opinion/services/patient/patientServices.dart';
import 'package:doctor_opinion/widgets/Auth_text_field.dart';
import 'package:doctor_opinion/widgets/doctor/email.dart';
import 'package:doctor_opinion/widgets/doctor/phone.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/doctor/username.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserService userService = UserService();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String _email = "";
  bool _vemail = false;
  String _phone = "";
  bool _vphone = false;
  String _username = "";
  bool _vusername = false;

  bool otpSent = false;

  void validateEmail(String email, bool e) {
    setState(() {
      _email = email;
      _vemail = e;
    });
  }

  void validatePhone(String phone, bool p) {
    setState(() {
      _phone = phone;
      _vphone = p;
    });
  }

  void validateUsername(String username, bool vuser) {
    setState(() {
      _username = username;
      _vusername = vuser;
    });
  }

  void register() async {
    if (_formKey.currentState!.validate()) {
      final userInfo = {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': _email,
        'phone': _phone,
        'username': _username,
        'password': passwordController.text,
      };

      final response = await userService.collectUserInfo(userInfo);
      if (response['message'] == 'OTP sent to email. Please verify.') {
        setState(() {
          otpSent = true;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => userOtpFormPage(email: _email),
          ),
        );
      } else {
        // Handle error
        print(response['error']);
      }
    } else {
      // Handle invalid form
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fix the errors in the form.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              child: Image.asset("lib/icons/back2.png")),
          onPressed: () {
            // Navigator.push(
            //     context,
            //     PageTransition(
            //         type: PageTransitionType.leftToRight, child: Login()));
          },
        ),
        title: Text(
          "Sign up",
          style: GoogleFonts.inter(
              color: Colors.black87,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0),
        ),
        toolbarHeight: 110,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),

                const SizedBox(height: 5),
                AuthTextField(
                  controller: firstNameController,
                  text: "First name",
                  icon: "lib/icons/email.png",
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Please enter your first name";
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 5),
                AuthTextField(
                  controller: lastNameController,
                  text: "Last name",
                  icon: "lib/icons/email.png",
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Please enter your last name";
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 5),
                Center(
                  child: EmailWidget(
                      con: emailController, validateEmail: validateEmail),
                ),
                const SizedBox(height: 5),

                UserNameWidget(
                    con: conusername, vadliateUsername: validateUsername),
                const SizedBox(height: 5),
                AuthTextField(
                  controller: passwordController,
                  text: "Enter your password",
                  icon: "lib/icons/lock.png",
                  // obscureText: true,
                  // validator: (value) {
                  //   if (value!.isEmpty || value.length < 6) {
                  //     return "Password must be at least 6 characters long";
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 5),
                // AuthTextField(
                //   controller: phoneController,
                //   text: "Phone",
                //   icon: "lib/icons/phone.png",
                //   keyboardType: TextInputType.phone,
                //   onChanged: (v) {
                //     validatePhone(v, v.length == 10);
                //   },
                //   validator: (value) {
                //     if (!_vphone) {
                //       return "Invalid phone number";
                //     }
                //     return null;
                //   },
                // ),
                Phonewidget(con: phoneController, validatePhone: validatePhone),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    Text(
                      "I agree to the terms and conditions",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 3, 190, 150),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Create account",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: const Color.fromARGB(255, 61, 60, 60),
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: LoginPage()),
                        );
                      },
                      child: Text(
                        "Sign in",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
