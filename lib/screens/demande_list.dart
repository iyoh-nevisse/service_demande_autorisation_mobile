// ignore_for_file: unused_local_variable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demandeautorisation/screens/demande_details.dart';
import 'package:demandeautorisation/services/api/demande_api.dart';
import 'package:demandeautorisation/utils/app_colors.dart';
import 'package:demandeautorisation/widget/app_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:demandeautorisation/models/demande.dart';
import 'package:intl/intl.dart';
import '../utils/app_constant.dart';
import 'notification_screen.dart';

class DemandesList extends StatefulWidget {
  static var tag = "/DemandesList";

  @override
  DemandesListState createState() => DemandesListState();
}

class DemandesListState extends State<DemandesList> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Container(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // TopBar(),
            SizedBox(
              height: AppBar().preferredSize.height,
            ),
            // 40.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20),
                    child: text("Demandes",
                        textColor: Colors.black,
                        fontFamily: fontBold,
                        fontSize: textSizeXLarge),
                  ),
                ]),
                    
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        Get.to(
                          () => const NotificationScreen(),
                          transition: Transition.cupertinoDialog,
                        );
                      },
                    )
                  ],
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: FutureBuilder(
                    future: fetchDemande(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Demande>> snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(const ItemDetails(),
                                      arguments: snapshot.data![index]);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  decoration: boxDecoration(
                                      radius: 16,
                                      showShadow: true,
                                      bgColor: context.scaffoldBackgroundColor),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      text(
                                      snapshot.data![index].reference ?? " ",
                                          textColor: Colors.black,
                                          fontSize: textSizeLargeMedium,
                                          fontFamily: fontSemibold),
                                      text(
                                          DateFormat('dd-MM-yyyy').format(
                                              snapshot.data![index].createdAt!),
                                          fontSize: textSizeMedium),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        decoration: boxDecoration(
                                            bgColor: SkyBlue2, radius: 16),
                                        child: text(
                                            snapshot.data![index].status,
                                            fontSize: textSizeMedium,
                                            textColor: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) =>
      //                 ServiceDetails("Service Details")));
      //   },
      // ),
    );
  }
}
