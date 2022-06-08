// ignore_for_file: avoid_print, non_constant_identifier_names

class Notifications {
  String? idNotification;
  String? idDemande; //cle etrangere du table demande
  String? idUser; //cle etrangere du table user
  String? messageAr;
  String? messageFr;
  DateTime? date_envoi;

  Notifications({
    this.idNotification,
    this.idDemande,
    this.idUser,
    this.messageAr,
    this.messageFr,
    this.date_envoi,
  });

  factory Notifications.fromJson(dynamic json) {
    print("json['date_envoi'] ${json['dateNotification']}");

    return Notifications(
      idNotification: json['idNotification'],
      idDemande: json['idDemande'],
      idUser: json['idUser'],
      messageAr: (json['messageAr'] != null) ? json['messageAr'] : "",
      messageFr: (json['messageFr'] != null) ? json['messageFr'] : "",
      date_envoi: json['date_envoi'],
    );
  }

  static List<Notifications> notificationsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Notifications.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Notification { idNotification: $idNotification, messageFr: $messageFr, messageAr:$messageAr, date_envoi:$date_envoi , idDemande:$idDemande, idUser:$idUser}';
  }
}
