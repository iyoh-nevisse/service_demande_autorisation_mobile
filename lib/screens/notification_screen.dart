// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:demandeautorisation/services/api/notification_api.dart';
import 'package:demandeautorisation/widget/app_widget.dart';

import '../models/notification.dart';
import '../utils/app_images.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        'Notification',
        center: true,
      ),
      body: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => ItemDetails("Demande ", Colors.green)),
          // );
        },
        child: FutureBuilder(
            future: fetchNotifications(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Notifications>> snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(thickness: 2);
                    },
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      // LSServiceModel data = getNotificationList()[i];
                      Notifications notification = snapshot.data![i];
                      var confirm = Confirm;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonCacheImageWidget(
                            Confirm.validate(),
                            40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          16.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                          (notification.messageFr != "")
                                              ? notification.messageFr!
                                              : notification.messageAr!,
                                          style: boldTextStyle())
                                      .expand(),
                                  Text("", style: secondaryTextStyle()),
                                ],
                              ),
                              4.height,
                              Text(notification.date_envoi.toString(),
                                  style: secondaryTextStyle()),
                            ],
                          ).expand()
                        ],
                      ).paddingAll(16);
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
