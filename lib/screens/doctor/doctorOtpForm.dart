import 'package:doctor_opinion/models/doctor/Doctor.dart';
import 'package:doctor_opinion/models/hiveModels/doctor_hive.dart';
import 'package:doctor_opinion/provider/DocProviders.dart';
import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:doctor_opinion/services/doctorServices.dart';
import 'package:doctor_opinion/services/hiveServices.dart';
import 'package:flutter/material.dart';
import 'package:doctor_opinion/services/patientServices.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DoctorOptForm extends StatefulWidget {
  final String email;

  DoctorOptForm({Key? key, required this.email}) : super(key: key);

  @override
  _DoctorOptFormState createState() => _DoctorOptFormState();
}

class _DoctorOptFormState extends State<DoctorOptForm> {
  final TextEditingController otpController = TextEditingController();
  final UserService userService = UserService();

  void verifyOtp(BuildContext context) async {
    // final response = await DoctorServices.verifyDocOtp(
    //     widget.email, otpController.text);
    // if (response['message'] == 'Success') {
    //   GoRouter.of(context).pushNamed(DoctorRoutes.homePage);
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Invalid OTP')),
    //   );
    // }
    // final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);

    // Call verifyDoctorOtp from DoctorProvider
    // await doctorProvider.verifyDoctorOtp(
    //   email: widget.email,
    //   otp: otpController.text,
    // );

final response = await DoctorServices.verifyDocOtp(widget.email, otpController.text);
 if (response['message'] == 'Success') {
        var doctorData = response['doctor'];
        DoctorClass doctor = DoctorClass.fromJson(doctorData);
        DoctorHive hiveDoctor = DoctorHive(
          id: doctor.id,
          firstName: doctor.firstName,
          lastName: doctor.lastName,
          address: '',
          phone: doctor.phone,
          email: doctor.email,
          username: doctor.username,
          profilePicture: doctor.profilePicture,
          gender: doctor.gender,
        );

        final hiveService = HiveService();
        await hiveService.saveDcotr(hiveDoctor);
      GoRouter.of(context).pushNamed(DoctorRoutes.homePage);

    // Check the provider state after verification
    // if (doctorProvider.isLoggedIn) {
    //   // Navigate to the home page if logged in
    //   GoRouter.of(context).pushNamed(DoctorRoutes.homePage);
    // } else {
    //   // Show error message if not logged in
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Invalid OTP')),
    //   );
    // }
  }
  else {
      // Show error message if not logged in
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
                "Verification !Doctor!",
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