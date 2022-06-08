// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:demandeautorisation/models/notification.dart';
import 'package:http/http.dart' as http;

import '../controller/env.dart';

Future<List<Notifications>> fetchNotifications() async {
  List<Notifications> notifications = [];
  var storage = const FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  print("fetchNotifications is called");
  final response = await http.get(
    Uri.parse(Env.STATIC_URI_BA + '/notifications/citoyen/all'),
    headers: <String, String>{HttpHeaders.authorizationHeader: "Bearer $token"},
  );

  if (response.statusCode == 200) {
    // print("Notifications get success ${response.body}");
    var data = json.decode(utf8.decode(response.bodyBytes));
    print("data :::::::: ${response.body}");
    var content = data["content"] as List;
    print("data content:::::::: $content");
    for (var c in content) {
      print("data c:::::::: $c");
      notifications.add(Notifications.fromJson(c));
      print("data c after :::::::: $c");
    }
    // print("Notifications list $notifications");
    return notifications;
  } else {
    print("Failed to load notification");
    throw Exception('Failed to load notification');
  }
}
