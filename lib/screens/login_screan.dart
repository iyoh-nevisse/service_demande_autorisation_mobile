// ignore_for_file: sized_box_for_whitespace, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:demandeautorisation/widget/app_widget.dart';
import 'package:get/get.dart';
import 'package:demandeautorisation/lang/lang.dart';
import '../services/api/keycloak_api.dart';
import '../utils/config.dart';
import '../utils/localisation_util.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  bool? isRemember = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
             Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownButton<Language>(
                  underline: const SizedBox(),
                  icon: const Icon(Icons.language),
                  onChanged: (Language? language) {
                    LocaleString.updateLanguageAppBar(language!.local);
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                      .toList()),
              ),
          

        ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Welcome to",style: boldTextStyle(size: 30))),
          10.height,
          Center(child: Text("Service Demande d'Autorisation",style: boldTextStyle(size: 25))),
          SizedBox(height:  fullHeight(context) * 0.08),
          Image(
            height: fullHeight(context) * 0.2,
            width: fullHeight(context) * 0.2,
            image: const AssetImage('assets/images/logo.png')
          ),
           SizedBox(height:  fullHeight(context) * 0.06),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: T3AppButton(
              textContent: "Sign in",
              onPressed: () async {
                try {
                  await AuthRepository.authenticate();
                  Get.offAll(
                    () => const MainScreen(),
                    transition: Transition.cupertinoDialog,
                  );
                } catch (e) {
                  print("Exception : $e");
                  Get.snackbar("Login failed", e.toString(),
                      backgroundColor: Colors.white);
                }
              },
            ),
          )

       
        ]),

    
    
    );
  }
}
