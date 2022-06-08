// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:demandeautorisation/screens/login_screan.dart';
import 'package:demandeautorisation/services/controller/binding/demande_binding.dart';
import 'package:demandeautorisation/utils/localisation_util.dart';

void main() {
  // ignore: unused_element
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  // Get.put(DemandeController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      translations: LocaleString(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      // fallbackLocale: ,
      home: LoginScreen(),
      initialBinding: DemandeBinding(),
    ),
  );
}
