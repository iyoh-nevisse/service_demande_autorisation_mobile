// ignore_for_file: avoid_print

import 'citoyen.dart';
import 'ministere.dart';

class Demande {
  int? id;
  String? contenu;
  String? motif;
  String? reference;
  String ? matricule ;
  bool? active;
  String? status;
  DateTime? createdAt;
  DateTime? dateDecision;
  String? idUser; //cle etrangere du classe user
  String? idAgent; //cle etrangere du classe agent
  List<Map>? documents = [];
  List<Map>? documentOutput = [];
  Ministere? ministere;
  Citoyen? citoyen;

  Demande({
    this.id,
    this.contenu,
    this.matricule,
    this.reference,
    this.motif,
    this.active,
    this.status,
    this.dateDecision,
    this.createdAt,
    this.idAgent,
    this.idUser,
    this.ministere,
    this.citoyen,
  });

  factory Demande.fromJson(dynamic json) {
    DateTime? createdAt = (json['createdAt'] != null)
        ? DateTime.tryParse(json['createdAt'])
        : null;
    DateTime? dateDecision = (json['dateDecision'] != null)
        ? DateTime.tryParse(json['dateDecision'])
        : null;
    // print("createdAt ::::::::: ${dateDecision.runtimeType}");
    // print("json['dateDecision'] ::::::::: ${json['dateDecision'].runtimeType}");
    return Demande(
      id: json['id'],
      contenu: json['contenu'],
      reference: json['reference'],
      motif: json['motif'],
      active: json['active'],
      status: json['status'],
      createdAt: createdAt,
      dateDecision: dateDecision,
      idUser: json['idUser'],
      idAgent: json['idAgent'],
      ministere:json['ministry'] != null? Ministere.fromJson(json['ministry']) :null,
      matricule: json['matricule'],
      citoyen: Citoyen.fromJson(json["citoyen"]),
      // documents: json['documents'],
      // documentOutput: json['documentOutput']
    );
  }

  Map<String, dynamic> toMap() {
    if (createdAt != null) {
      // String t = "" + createdAt;
      // print(
      //     "createdAt.toString() hhhh ${createdAt!.toString().replaceFirst(" ", "T")}");
    }
    return {
      'id': id,
      'contenu': contenu,
      'matricule': matricule,
      'motif': motif,
      'reference':reference,
      'active': active,
      'status': status,
      'createdAt': (createdAt == null)
          ? null
          : createdAt!.toString().replaceFirst(" ", "T"),
      'dateDecision': (dateDecision == null)
          ? null
          : dateDecision!.toString().replaceFirst(" ", "T"),
      'idUser': idUser,
      'idAgent': idAgent,
      'ministry':ministere,
      // 'documents': documents,
    };
  }

  static List<Demande> demandesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Demande.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Demande { id: $id, contenu: $contenu,matricule: $matricule,reference:$reference, active:$active, status:$status , createdAt:$createdAt, dateDecision:$dateDecision,idAgent:$idAgent , idUser:$idUser,ministry:$ministere}';
  }
}
