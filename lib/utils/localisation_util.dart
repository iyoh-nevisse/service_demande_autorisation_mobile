import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demandeautorisation/lang/ar_sa.dart';
import 'package:demandeautorisation/lang/en_us.dart';
import 'package:demandeautorisation/lang/hi_in.dart';

class LocaleString extends Translations {
  // String countryCode = 'us';
  // String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
  //    (match) => String.fromCharCode(match.group(0).codeUnitAt(0) + 127397));
  // print(flag);

  static List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'HINDI', 'locale': const Locale('hi', 'IN')},
    {'name': 'عربي', 'locale': const Locale('ar', 'SA')},
  ];

  static updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  static void updateLanguageAppBar(Locale locale) {
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        //ENGLISH LANGUAGE
        'en_US': enUS,
        //HINDI LANGUAGE
        'hi_IN': hiIN,
        //ARABIC LANGUAGE
        'ar_SA': arSA,
      };
}
