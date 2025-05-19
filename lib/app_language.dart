import 'package:flutter/material.dart';
import 'helper.dart';

class AppLanguageProvider extends ChangeNotifier {
  Locale _appLocale = const Locale('en');
  String _locale = 'en';

  Locale get appLocale => _appLocale;
  String get locale => _locale;

  Future<void> fetchLocale() async {
    var languageCode = await Helper.getLanguage();
    if (languageCode.isNotEmpty) {
      _locale = languageCode;
      _appLocale = Locale(languageCode);
    }
    notifyListeners();
  }

  Future<void> updateLanguage(String languageCode) async {
    if (_appLocale == Locale(languageCode)) {
      return;
    }
    _locale = languageCode;
    _appLocale = Locale(languageCode);
    await Helper.setLanguage(languageCode);
    notifyListeners();
  }
}
