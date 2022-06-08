// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:demandeautorisation/models/demande.dart';
import 'package:demandeautorisation/models/user.dart';
import '../controller/demande_controller.dart';
import '../controller/env.dart';

Future<Demande> saveDemande(Demande demande, Map<String, PlatformFile> files) async {

  
  print(files);

  var storage = const FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  print('createDemande is called');
  
  final response = await http.post(
    Uri.parse(Env.STATIC_URI_BA + '/demandes/save'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
    body: jsonEncode(demande.toMap()),
  ).timeout(const Duration(seconds: 5));

  print(response.statusCode);
  print(response.body);
  

    
  if (response.statusCode == 200) {

    final res = jsonDecode(response.body);
    final dmd = Demande.fromJson(res);
  
    if (DemandeController.user == null) {
      User user = User.fromJson(dmd.citoyen);
      DemandeController.user = user;
    } 
    for (var e in files.values) {
      print('start sending attached files');
      print('e.path.toString() ::::::::::::::::: ${e.path.toString()}');
      await _uploadFile(e.path.toString(), dmd, token!);
      print('file ${e.path.toString()} is sent');
    }

    return dmd;
  } else {
    throw Exception('Failed to create Demande.');
  }
}


Future<Demande> updateDemande(Demande demande) async {
  var storage = const FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  print('updateDemande is called');
  final response = await http.post(
    Uri.parse(Env.STATIC_URI_BA + '/demandes/updateStatus'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
    body: jsonEncode({'id': demande.id}),
  );
  // .timeout(const Duration(seconds: 5));
  

  if (response.statusCode == 200) {
    Demande demande = Demande.fromJson(jsonDecode(response.body));
    print("demande updated success");
    return demande;
  } else {
    print('Failed to update Demande statuscode: ${response.statusCode}');
    throw Exception('Failed to update Demande');
  }
}

Future<int> _uploadFile(String path, Demande demande, String token) async {
  print("najah 2");
  var uri = Uri.parse(Env.STATIC_URI_BA + '/documents/save');
  var request = http.MultipartRequest('POST', uri);
  request.headers.addAll({"Authorization": "Bearer $token"});
  request.fields['idDemande'] = demande.id.toString();
  request.fields['designationFr'] = 'designationFr';
  request.files.add(await http.MultipartFile.fromPath('files', path));
  print("request object :::::::::::: $request");
  var response = await request.send();
  var responsed = await http.Response.fromStream(response);
  final responseData = json.decode(responsed.body);
  print("response data :::::::::::: $responseData");
  if (response.statusCode == 200) {
    print('Uploaded ...');
  } else {
    print(
        'Something went wrong! stat _uploadFile statusCode:::: ${response.statusCode}');
    // print('_uploadFile body:::: ${jsonDecode(response.)}');
  }
  return response.statusCode;
}

Future<Demande> getDemande(String id) async {
  var storage = const FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  final response = await http.get(
    Uri.parse(Env.STATIC_URI_BA + '/demandes/' + id),
    headers: <String, String>{HttpHeaders.authorizationHeader: "Bearer $token"},
  );

  if (response.statusCode == 200) {
    print("demande geted successhhhh :::::::: ${json.decode(response.body)}");
    return Demande.fromJson(json.decode(response.body));
  } else {
    print("Failed to get demande");
    throw Exception('Failed to get demande');
  }
}

Future<List<Demande>> fetchDemande() async {
  List<Demande> demandes = [];
  var storage = const FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  print("fetchDemande is called");
  final response = await http.get(
    Uri.parse(Env.STATIC_URI_BA + '/demandes/citoyen/all'),
    headers: <String, String>{HttpHeaders.authorizationHeader: "Bearer $token"},
  );
 


  if (response.statusCode == 200) {
    print("demandes get success ${response.body}");
    var data = json.decode(response.body);
    print("data :::::::: ${response.body}");
    var content = data["content"] as List;
    if (content.isNotEmpty) {
      if (DemandeController.user == null) {
        User user = User.fromJson(content.first["citoyen"]);
        DemandeController.user = user;
      }
    }
    print("data content:::::::: $content");
    for (var c in content) {
      print("data element c:::::::: $c");
      List<Map<String, dynamic>> documents = [];
      List<Map<String, dynamic>> documentsOutput = [];
      Demande demande = Demande.fromJson(c);
      print("demandeee element d:::::::: $c");
      print(" c['documents']:::::::: ${c['documents']}");
      for (var d in (c['documents'])) {
        print("Document d:::::::: $d");
        // print("Document.fromJson(d):::::::: ${Document.fromJson(d)}");
        documents.add(d);
      }

      for (var d in (c['documentOutput'])) {
        print("Document d:::::::: $d");
        // print("Document.fromJson(d):::::::: ${Document.fromJson(d)}");
        documentsOutput.add(d);
      }
      demande.documentOutput = documentsOutput;
      demande.documents = documents;
      demandes.add(demande);
    }
    print("demandes list $demandes");
    return demandes;
  } else {
    print("Failed to load demandes");
    throw Exception('Failed to load demandes');
  }
}

Future<void> download({required String url}) async {
  var storage = const FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  bool hasPermission = await _requestWritePermission();
  if (!hasPermission) {
    print("permission denede");
    return;
  }

  // gets the directory where we will download the file.
  var dir = await getTemporaryDirectory();

  // You should put the name you want for the file here.
  // Take in account the extension.
  String fileName = 'nomFichier';

  // downloads the file
  BaseOptions options = BaseOptions(headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    HttpHeaders.authorizationHeader: "Bearer $token"
  });
  Dio dio = Dio(options);

  print("url ::::::::: $url");
  await dio.download(url, "${dir.path}/$fileName");
  print("{dir.path}/fileName ::::: ${dir.path}/$fileName");

  // opens the file
  OpenFile.open("${dir.path}/$fileName", type: 'application/pdf');
}

// requests storage permission
Future<bool> _requestWritePermission() async {
  await Permission.storage.request();
  return await Permission.storage.request().isGranted;
}


Future<dynamic> loadData(url) async {
  print(Env.STATIC_URI_BA + url);
    try {
      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: "token");
      final response = await http.get(
        Uri.parse(Env.STATIC_URI_BA + url),
        headers: <String, String>{HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      print(response.statusCode);
      print(utf8.decode(response.bodyBytes));
   
      if (200 == response.statusCode) { 
        final type = utf8.decode(response.bodyBytes);
        return type;
      } else {
        return dynamic;
      }
    } catch (e) {
      print(e);
      return dynamic;
    }
  }