import 'dart:ui';

import 'package:get/get.dart';

import '../translation/ar.dart';
import '../translation/en_US.dart';

class LocalizationService extends Translations {
  static final locale = Locale('ar', "AR");

  static final langs = ['English', "Urdu", 'Arabic'];

  static final locales = [
    Locale('en', 'US'),
    Locale('ur', 'PK'),
    Locale('fr', null)
  ];
  @override
  Map<String, Map<String, String>> get keys => {'en_US': en, 'ar': ar};

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    int index = langs.indexOf(lang);
    return locales[index];
  }
}
