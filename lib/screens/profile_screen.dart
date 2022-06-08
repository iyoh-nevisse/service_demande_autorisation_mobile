// ignore_for_file: use_key_in_widget_constructors, body_might_complete_normally_nullable


import 'package:demandeautorisation/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.green,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: ColorGreen3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          child: Image.asset("assets/images/men1.png"),
                          radius: 40.0,
                          backgroundColor: ColorCyan3),
                      8.height,
                      Text('johnsmith Pham',
                          style: boldTextStyle(color: white, size: 24)),
                      4.height,
                      Text('johnsmith@gmail.com',
                          style: secondaryTextStyle(color: white, size: 16)),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
