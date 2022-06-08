class ChampSup {
  int? id;
  String? designationAr; //cle etrangere du table demande
  String? designationFr; //cle etranger du table champsup
  String? type; //cle etranger du table document
  DateTime? dateActivation;
  DateTime? dateDeactivation;

  ChampSup(
      {this.id,
      this.designationAr,
      this.designationFr,
      this.type,
      this.dateActivation,
      this.dateDeactivation});

  factory ChampSup.fromJson(dynamic json) {
    return ChampSup(
      id: json['id'],
      designationAr: json['designationAr'],
      designationFr: json['designationFr'],
      type: json['type'],
      dateActivation: json['dateActivation'],
      dateDeactivation: json['dateDeactivation'],
    );
  }

  static List<ChampSup> champSupsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return ChampSup.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'ChampSup { idChampSup: $id, designationAr: $designationAr, designationFr:$designationFr, type:$type, dateActivation :$dateActivation, dateDesactivtion:$dateDeactivation ';
  }
}
