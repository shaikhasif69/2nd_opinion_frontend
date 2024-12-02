import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward(); 

    _preloadAssets().then((_) => _navigateToNextScreen());
  }

 

  Future<void> _preloadAssets() async {
    try {
      await Future.wait([
        precacheImage(const AssetImage('assets/images/main.png'), context),
      ]);
    } catch (e) {
      debugPrint("Error preloading images: $e");
    }
  }

  void _navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDocLoggedIn = prefs.getBool('doctor_isLoggedIn') ?? false;
    bool isUserLoggedIn = prefs.getBool('user_isLoggedIn') ?? false;

    Future.delayed(const Duration(seconds: 2), () {
      if (isDocLoggedIn) {
        GoRouter.of(context).go(DoctorRoutes.homePage);
      } else if(isUserLoggedIn) {
        GoRouter.of(context).go(PatientRoutes.homePage);
      }
      else{
        GoRouter.of(context).go(CommonRoutes.onBoardScreen);

      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FadeTransition(
        opacity: _controller,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: Image.asset(
                  'assets/images/main.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
