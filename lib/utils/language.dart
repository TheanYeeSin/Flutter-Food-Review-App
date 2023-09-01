import 'package:flutter/material.dart';
import 'package:foodreviewapp/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageManager extends ChangeNotifier {
  static Locale _locale = L10n.all.first;

  Locale get locale => _locale;

  LanguageManager() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguageCode = prefs.getString('languageCode');
    if (savedLanguageCode != null) {
      _locale = Locale(savedLanguageCode);
      notifyListeners();
    }
  }

  void changeLanguage(Locale locale) async {
    _locale = locale;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
  }
}
