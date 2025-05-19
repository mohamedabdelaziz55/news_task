
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static Future<void> setLanguage(String language) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('language', language);
  }

  static Future<String> getLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('language') ?? 'en';
  }
}


