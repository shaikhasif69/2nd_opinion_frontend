import 'package:doctor_opinion/components/side_menu.dart';
import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:doctor_opinion/screens/On_Board/on_boarding.dart';
import 'package:doctor_opinion/screens/doctor/signup.dart';
import 'package:doctor_opinion/screens/loginPage.dart';
import 'package:doctor_opinion/screens/otpForm.dart';
import 'package:doctor_opinion/screens/patient/Dashboard_screen.dart';
import 'package:doctor_opinion/screens/patient/home_page.dart';
import 'package:doctor_opinion/screens/patient/Profile_screen.dart';
// import 'package:doctor_opinion/screens/patient/homepage.dart';
import 'package:doctor_opinion/screens/patient/register.dart';
import 'package:doctor_opinion/screens/views/Screen1.dart';
import 'package:doctor_opinion/screens/views/appointment.dart';
import 'package:doctor_opinion/screens/views/doctor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyGoRouter {
  final GoRouter router = GoRouter(routes: [
    // GoRoute(
    //   path: "/",
    //   name: CommonRoutes.login,
    //   pageBuilder: (context, state) {
    //     // return MaterialPage(child: LoginPage());
    //     return MaterialPage(child: LoginPage());
    //   },
    // ),

    // GoRoute(
    //   path: "/",
    //   name: CommonRoutes.login,
    //   pageBuilder: (context, state) {
    //     return MaterialPage(child: Homepage());
    //   },
    // ),

    //uncomment this later!
    GoRoute(
      path: "/",
      name: CommonRoutes.login,
      pageBuilder: (context, state) {
    return MaterialPage(child: on_boarding());
      },
    ),
    GoRoute(
        path: DoctorRoutes.signUp,
        name: DoctorRoutes.signUp,
        pageBuilder: (context, state) {
          return MaterialPage(child: doctorSignUpPage());
        }),

    GoRoute(
        path: PatientRoutes.signUp,
        name: PatientRoutes.signUp,
        pageBuilder: (context, state) {
          return MaterialPage(child: Register());
        }),

    GoRoute(
        path: PatientRoutes.pProfile,
        name: PatientRoutes.pProfile,
        pageBuilder: (context, state) {
          return MaterialPage(child: Profile_screen());
        }),

    GoRoute(
        path: PatientRoutes.homePage,
        name: PatientRoutes.homePage,
        pageBuilder: (context, state) {
          return MaterialPage(child: Homepage());
        }),

    GoRoute(
        path: PatientRoutes.doctorProfile,
        name: PatientRoutes.doctorProfile,
        pageBuilder: (context, state) {
          return MaterialPage(child: DoctorDetails());
        }),
    GoRoute(
            path: PatientRoutes.bookAppointment,
            name: PatientRoutes.bookAppointment,
            pageBuilder: (context, state) {
              return MaterialPage(child: appointment());
            }),
    GoRoute(
        path: PatientRoutes.dashboard,
        name: PatientRoutes.dashboard,
        pageBuilder: (context, state) {
          return MaterialPage(child: Dashboard());
        }),
  ]);
}
