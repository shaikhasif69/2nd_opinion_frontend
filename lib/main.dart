import 'package:doctor_opinion/models/hiveModels/doctor_hive.dart';
import 'package:doctor_opinion/models/hiveModels/user.dart';
import 'package:doctor_opinion/provider/DocProviders.dart';
import 'package:doctor_opinion/provider/UserProviders.dart';
import 'package:doctor_opinion/router/router.dart';
import 'package:doctor_opinion/screens/loginPage.dart';
import 'package:doctor_opinion/services/authServices.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:doctor_opinion/Screens/On_Board/on_boarding.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'dart:async';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart' as provider;

// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveUserAdapter());
  Hive.registerAdapter(DoctorHiveAdapter());
  await AuthService.getPref();
  runApp(
    riverpod.ProviderScope(
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
          provider.ChangeNotifierProvider(
            create: (context) => DoctorProvider(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

final route = MyGoRouter();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, ScreenType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: route.router.routeInformationParser,
          routeInformationProvider: route.router.routeInformationProvider,
          routerDelegate: route.router.routerDelegate,
          title: '2nd Opinion',
          theme: FlexThemeData.light(
            scheme: FlexScheme.blumineBlue,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 7,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 10,
              blendOnColors: false,
              useTextTheme: true,
              useM2StyleDividerInM3: true,
              alignedDropdown: true,
              useInputDecoratorThemeInDialogs: true,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
            useMaterial3: true,
            swapLegacyOnMaterial3: true,
          ),
          themeMode: ThemeMode.light,
          darkTheme: FlexThemeData.dark(
            scheme: FlexScheme.blumineBlue,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 13,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 20,
              useTextTheme: true,
              useM2StyleDividerInM3: true,
              alignedDropdown: true,
              useInputDecoratorThemeInDialogs: true,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
            useMaterial3: true,
            swapLegacyOnMaterial3: true,
          ),
        );
      },
    );
  }
}
