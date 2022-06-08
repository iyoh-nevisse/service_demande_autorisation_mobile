// To parse this JSON data, do
//
//     final ministere = ministereFromJson(jsonString);

import 'dart:convert';

List<Ministere> ministereFromJson(String str) => List<Ministere>.from(json.decode(str).map((x) => Ministere.fromJson(x)));

String ministereToJson(List<Ministere> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ministere {
    Ministere({
        this.id,
        this.nameAr,
        this.nameFr,
        this.nameEn,
        this.active,
    });

    int ? id;
    dynamic nameAr;
    String ?nameFr;
    String? nameEn;
    bool? active;

    factory Ministere.fromJson(Map<String, dynamic> json) => Ministere(
        id: json["id"],
        nameAr: json["nameAR"],
        nameFr: json["nameFr"],
        nameEn: json["nameEn"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nameAR": nameAr,
        "nameFr": nameFr,
        "nameEn": nameEn,
        "active": active,
    };
}
