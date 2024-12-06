import 'package:doctor_opinion/components/side_menu.dart';
import 'package:doctor_opinion/models/doctor/Doctor.dart';
import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:doctor_opinion/screens/On_Board/on_boarding.dart';
import 'package:doctor_opinion/screens/On_Board/onboding_screen.dart';
import 'package:doctor_opinion/screens/doctor/dHomePage.dart';
import 'package:doctor_opinion/screens/doctor/dLoginPage.dart';
import 'package:doctor_opinion/screens/doctor/doctorOtpForm.dart';
import 'package:doctor_opinion/screens/doctor/signup.dart';
import 'package:doctor_opinion/screens/login.dart';
import 'package:doctor_opinion/screens/loginPage.dart';
import 'package:doctor_opinion/screens/patient/login_form.dart';
import 'package:doctor_opinion/screens/patient/userOtpForm.dart';
import 'package:doctor_opinion/screens/patient/Dashboard_screen.dart';
import 'package:doctor_opinion/screens/patient/home_page.dart';
import 'package:doctor_opinion/screens/patient/Profile_screen.dart';
// import 'package:doctor_opinion/screens/patient/homepage.dart';
import 'package:doctor_opinion/screens/patient/register.dart';
import 'package:doctor_opinion/screens/views/Screen1.dart';
import 'package:doctor_opinion/screens/views/appointment.dart';
import 'package:doctor_opinion/screens/views/doctor_details_screen.dart';
import 'package:doctor_opinion/screens/views/searchPage.dart';
import 'package:doctor_opinion/screens/views/splash_screen.dart';
import 'package:doctor_opinion/widgets/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyGoRouter {
  final GoRouter router = GoRouter(routes: [
    //Patient routes
    //uncomment this later!
    GoRoute(
      path: CommonRoutes.login,
      name: CommonRoutes.login,
      pageBuilder: (context, state) {
        return MaterialPage(child: on_boarding());
      },
    ),
    GoRoute(
      path: '/',
      redirect: (context, state) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        final bool isDoctorLoggedIn =
            prefs.getBool('doctor_isLoggedIn') ?? false;
        final bool isUserLoggedIn = prefs.getBool('user_isLoggedIn') ?? false;

        if (isDoctorLoggedIn) {
          return DoctorRoutes.homePage;
        } else if (isUserLoggedIn) {
          return PatientRoutes.homePage;
        } else {
          // return DoctorRoutes.loginPage;
          return CommonRoutes.splashScreen;
        }
      },
    ),

    // common routes:
    GoRoute(
        path: CommonRoutes.onBoardScreen,
        name: CommonRoutes.onBoardScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: on_boarding());
        }),

         GoRoute(
        path: CommonRoutes.splashScreen,
        name: CommonRoutes.splashScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        }),

    GoRoute(
        path: DoctorRoutes.signUp,
        name: DoctorRoutes.signUp,
        pageBuilder: (context, state) {
          return MaterialPage(child: doctorSignUpPage());
        }),
    GoRoute(
      path: DoctorRoutes.loginPage,
      name: DoctorRoutes.loginPage,
      pageBuilder: (context, state) {
        return MaterialPage(child: DoctorLogin());
      },
    ),

    // user login : 
    GoRoute(
      path: PatientRoutes.uLogin,
      name: PatientRoutes.uLogin,
      pageBuilder: (context, state) {
        return MaterialPage(child: login());
      },
    ),
    GoRoute(
        path: '${DoctorRoutes.docOtp}/:email',
        name: DoctorRoutes.docOtp,
        pageBuilder: (context, state) {
          final email = state.pathParameters['email']!;
          return MaterialPage(
              child: DoctorOptForm(
            email: email,
          ));
        }),

    GoRoute(
      path: DoctorRoutes.homePage,
      name: DoctorRoutes.homePage,
      pageBuilder: (context, state) {
        return MaterialPage(child: DoctorHomePage());
      },
    ),

    //Patient Routes
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
        path: PatientRoutes.searchSection,
        name: PatientRoutes.searchSection,
        pageBuilder: (context, state) {
          return MaterialPage(child: searchPage());
        }),

GoRoute(
  path: PatientRoutes.doctorProfile,
  name: PatientRoutes.doctorProfile,
  pageBuilder: (context, state) {
    final doctor = state.extra as DoctorClass;
    return MaterialPage(
      child: DoctorDetails(doctor: doctor),
    );
  },
),

  GoRoute(path: 
  PatientRoutes.chatDoctorScreen,
  name: PatientRoutes.chatDoctorScreen,
  pageBuilder: (context, state) {
    final doctor = state.extra as DoctorClass;
    return MaterialPage(child: ChatScreen(doctor: doctor));
  },),
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
