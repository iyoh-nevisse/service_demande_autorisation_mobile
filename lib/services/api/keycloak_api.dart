import 'dart:convert';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../screens/home_screen.dart';
import '../controller/env.dart';

class AuthRepository {
  static List userRols = [];
  static List userAttribute = [];

  static Future<String> logout() async {
    String url = Env.SSO_UL + '/protocol/openid-connect/logout';

    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'cache-control': 'no-cache',
    };

    // Create storage
    var storage = const FlutterSecureStorage();

    // Read value
    String? refreshToken = await storage.read(key: 'refreshToken');

    Map<String, String> data = {
      'client_id': Env.CLIENT_ID,
      'client_secret': Env.CLIENT_SECRET,
      'refresh_token': refreshToken!,
    };

    http.Response respons =
        await http.post(Uri.parse(url), headers: headers, body: data);
    if (respons.statusCode == 204) {
      storage.deleteAll();
      return "success";
    } else {
      throw Exception(respons.body);
    }
  }

  static authenticate() async {
    FlutterAppAuth appAuth = const FlutterAppAuth();

    final AuthorizationTokenResponse? result =
        await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        Env.CLIENT_ID,
        Env.REDIRECT_URI,
        clientSecret: Env.CLIENT_SECRET,
        issuer: Env.SSO_UL,
        scopes: ['openid', 'profile'],
        allowInsecureConnections: true,
      ),
    );

    var storage = const FlutterSecureStorage();

    await storage.write(key: 'refreshToken', value: result!.refreshToken);
    await storage.write(key: 'token', value: result.accessToken);
    await storage.write(
        key: 'accessTokenExpirationDateTime',
        value: result.accessTokenExpirationDateTime.toString());

    // info();
  }

  static tokenExistenceVerification() async {
    var storage = const FlutterSecureStorage();
    String? value = await storage.read(key: "token");
    if (value != null) {
      Get.off(const MyHomePage(
        title: 'Title',
      ));
    }
    // FlutterNativeSplash.remove();
  }

  static info() async {
    String url = Env.SSO_UL + '/protocol/openid-connect/token/introspect';
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'cache-control': 'no-cache',
    };

    Map<String, String> data = {
      'client_id': Env.CLIENT_ID,
      'client_secret': Env.CLIENT_SECRET,
      'token': token!,
    };
    http.Response respons =
        await http.post(Uri.parse(url), headers: headers, body: data);
    var res = jsonDecode(respons.body);
    if (respons.statusCode == 200) {
      userRols = res['realm_access']['roles'];
    }
  }
}
