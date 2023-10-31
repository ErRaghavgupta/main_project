import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static Future<SharedPreferences> getPrefs() async {
    return await SharedPreferences.getInstance();
  }
}
  String onboardingKey = "onboarding_key";


