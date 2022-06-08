import 'package:flutter/material.dart';

class Language {
  final int id;
  final String flag;
  final String name;
  final Locale local;
  Language(this.id, this.flag, this.name, this.local);

  // String countryCode = 'us';
  // String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
  //    (match) => String.fromCharCode(match.group(0).codeUnitAt(0) + 127397));
  // print(flag);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", const Locale('en', 'US')),
      Language(2, "🇮🇳", "Hindi", const Locale('hi', 'IN')),
      Language(3, "🇲🇷", "اَلْعَرَبِيَّةُ", const Locale('ar', 'SA')),
    ];
  }
}
