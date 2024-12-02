import 'package:doctor_opinion/models/hiveModels/user.dart';
import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:doctor_opinion/services/authServices.dart';
import 'package:doctor_opinion/services/hiveServices.dart';
import 'package:flutter/material.dart';
import 'package:doctor_opinion/services/patientServices.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/patient/User.dart';

class userOtpFormPage extends StatefulWidget {
  final String email;

  userOtpFormPage({Key? key, required this.email}) : super(key: key);

  @override
  _userOtpFormPageState createState() => _userOtpFormPageState();
}

class _userOtpFormPageState extends State<userOtpFormPage> {
  final TextEditingController otpController = TextEditingController();
  final AuthService _authService = AuthService();
  final UserService userService = UserService();

  void verifyOtp(BuildContext context) async {
    try {
      final response =
          await userService.verifyOtp(widget.email, otpController.text);
      if (response['response'] == 'Success') {
        User user = User.fromJson(response['user']);
        // HiveUser hiveUser = HiveUser(
        //   id: user.id,
        //   firstName: user.firstName,
        //   lastName: user.lastName,
        //   address: user.address,
        //   phone: user.phone,
        //   email: user.email,
        //   username: user.username,
        //   profilePicture: user.profilePicture,
        //   gender: user.gender,
        // );

        // final hiveService = HiveService();
        // await hiveService.saveUser(hiveUser);
        await _authService.storeLoginDetails(
          'user',
          response['token'] ?? '',
          widget.email,
        );
        print('Navigating to home page...');
        GoRouter.of(context).go(PatientRoutes.homePage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid OTP')),
        );
      }
    } catch (e) {
      print('Error during OTP verification: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('OTP Verification'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Column(
            children: [
              const Text(
                "Verification",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: const Text(
                  "Enter the code sent to your Email",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: Text(
                  widget.email,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter OTP',
                ),
                maxLength: 6,
                onChanged: (value) {
                  if (value.length == 6) {
                    print("yes yes all set");
                    // verifyOtp(
                    //     context);
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => verifyOtp(context),
                child: Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
