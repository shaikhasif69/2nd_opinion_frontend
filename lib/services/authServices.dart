import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
        static late SharedPreferences pref;
  static Future<SharedPreferences> getPref() async {
    pref = await SharedPreferences.getInstance();
    return pref;
  }
  Future<void> storeLoginDetails(String userType, String token, String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('${userType}_isLoggedIn', true);
    await prefs.setString('${userType}_token', token);
    await prefs.setString('${userType}_username', username);
  }

  Future<String> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDoctorLoggedIn = prefs.getBool('doctor_isLoggedIn') ?? false;
    bool isUserLoggedIn = prefs.getBool('user_isLoggedIn') ?? false;

    if (isDoctorLoggedIn) {
      return 'doctor';
    } else if (isUserLoggedIn) {
      return 'user';
    } else {
      return "null";
    }
  }
}
