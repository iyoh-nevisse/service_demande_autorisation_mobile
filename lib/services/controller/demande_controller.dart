// ignore_for_file: avoid_print

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demandeautorisation/models/user.dart';

import '../../models/ministere.dart';

class DemandeController extends GetxController {
  static TextEditingController contenuController = TextEditingController();
  static TextEditingController matriculeController = TextEditingController();
  static Ministere? ministere;
  var currentStep = 0.obs;
  var files = <String, PlatformFile>{}.obs;
  static User? user;
}
