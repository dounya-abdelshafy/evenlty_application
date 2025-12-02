import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  //todo: data
  String appLanguage = 'en';

  //todo: change language
  void changeLanguage(String newLanguage) {
    if (newLanguage == appLanguage) {
      return;
    }
    appLanguage = newLanguage;
    //todo: after change data => call function:
    notifyListeners();
  }
}
