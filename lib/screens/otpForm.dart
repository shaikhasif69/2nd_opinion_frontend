import 'package:flutter/material.dart';
import 'package:doctor_opinion/services/patient/patientServices.dart';

class OtpFormPage extends StatefulWidget {
  final String email;

  OtpFormPage({Key? key, required this.email}) : super(key: key);

  @override
  _OtpFormPageState createState() => _OtpFormPageState();
}

class _OtpFormPageState extends State<OtpFormPage> {
  final TextEditingController otpController = TextEditingController();
  final UserService userService = UserService();

  void verifyOtp(BuildContext context) async {
    final response =
        await userService.verifyOtp(widget.email, otpController.text);
    print(response['response']);
    print('see above!');
    if (response['response'] == 'Success') {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP')),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter OTP',
                ),
                maxLength: 6, // Adjust the length as needed
                onChanged: (value) {
                  if (value.length == 6) {
                    verifyOtp(
                        context); // Automatically verify when 6 digits are entered
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
