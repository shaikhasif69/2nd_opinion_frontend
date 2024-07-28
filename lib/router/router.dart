import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:doctor_opinion/screens/doctor/signup.dart';
import 'package:doctor_opinion/screens/loginPage.dart';
import 'package:doctor_opinion/screens/otpForm.dart';
import 'package:doctor_opinion/screens/patient/homepage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyGoRouter {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: "/",
      name: CommonRoutes.login,
      pageBuilder: (context, state) {
        // return MaterialPage(child: LoginPage());
        return MaterialPage(child: LoginPage());
      },
    ),
    GoRoute(
        path: DoctorRoutes.signUp,
        name: DoctorRoutes.signUp,
        pageBuilder: (context, state) {
          return MaterialPage(child: doctorSignUpPage());
        })
  ]);
}
//     // GoRoute(
//     //   path: "/",
//     //   name: CommonRoutes.root,
//     //   pageBuilder: (context, state) {
//     //     return MaterialPage(
//     //         child: BlindHomePage(
//     //       key: state.pageKey,
//     //     ));
//     //   },
//     // ),
//     GoRoute(
//       path: "/root/login",
//       name: CommonRoutes.login,
//       pageBuilder: (context, state) {
//         return MaterialPage(
//             child: LoginPage(
//           key: state.pageKey,
//         ));
//       },
//     ),
//     GoRoute(
//       path: "/root/signUp",
//       name: CommonRoutes.signUp,
//       pageBuilder: (context, state) {
//         return MaterialPage(
//             child: RegisterPage(
//           key: state.pageKey,
//         ));
//       },
//     ),
//     GoRoute(
//       path: "/root/students/b_dashboard",
//       name: StudentsRoutes.blindHomepage,
//       pageBuilder: (context, state) {
//         return MaterialPage(
//             child: UserDashBoard(
//           key: state.pageKey,
//         ));
//       },
//     ),
//     GoRoute(
//       path: "/root/students/quiz",
//       name: StudentsRoutes.quiz,
//       pageBuilder: (context, state) {
//         return MaterialPage(child: QuizScreen());
//       },
//     ),
//   ]);
// }
