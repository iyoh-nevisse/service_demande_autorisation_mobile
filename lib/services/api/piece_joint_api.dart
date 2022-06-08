// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:demandeautorisation/models/champsup.dart';

import '../controller/env.dart';

Future<List<ChampSup>> fetchAdditinalField() async {
  List<ChampSup> champsups = [];
  var storage = const FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  final response = await http.get(
    Uri.parse(Env.STATIC_URI_BA + '/getAllFields'),
    headers: <String, String>{HttpHeaders.authorizationHeader: "Bearer $token"},
  );

  if (response.statusCode == 200) {
    print("field loaded success");
    var data = json.decode(utf8.decode(response.bodyBytes)) as List;
    for (var c in data) {
      champsups.add(ChampSup.fromJson(c));
    }
    return champsups;
  } else {
    print("Failed to load additional field");
    throw Exception('Failed to load additional field');
  }
}
