import 'package:doctor_opinion/components/constant.dart';
import 'package:doctor_opinion/models/patient/User.dart';
import 'package:doctor_opinion/provider/UserProviders.dart';
import 'package:doctor_opinion/services/doctorServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorDashboard extends StatefulWidget {
  DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    try {
      await DoctorServices.fetchAllPatients(context);
    } catch (e) {
      print("Error fetching patients: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final users = userProvider.users;

        if (users == null || users.isEmpty) {
          return Scaffold(
            backgroundColor: MyColors.backgroundColorLight,
            body: Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text("No patients available."),
            ),
          );
        }

        return Scaffold(
          backgroundColor: MyColors.backgroundColorLight,
          body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(
                    "${user.userObject.firstName ?? 'N/A'} ${user.userObject.lastName ?? 'N/A'}"),
                subtitle: Text(user.userObject.email ?? 'No email'),
              );
            },
          ),
        );
      },
    );
  }
}
