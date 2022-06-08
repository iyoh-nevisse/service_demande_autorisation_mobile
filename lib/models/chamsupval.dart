class Champsupval {
  String? idChampsupval;
  String? idDemande; //cle etrangere du table demande
  String? idChampsup; //cle etranger du table champsup
  String? idDocument; //cle etranger du table document
  String? valeurChamp;

  Champsupval({
    this.idChampsupval,
    this.idDemande,
    this.idDocument,
    this.idChampsup,
    this.valeurChamp,
  });

  factory Champsupval.fromJson(dynamic json) {
    return Champsupval(
      idChampsupval: json['idChampsupval'] as String,
      idDemande: json['idDemande'] as String,
      idDocument: json['idDocument'] as String,
      idChampsup: json['idChampsup'] as String,
      valeurChamp: json['valeurChamp'] as String,
    );
  }

  static List<Champsupval> champsupvalsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Champsupval.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Champsupval { idChampsupval: $idChampsupval, idDocument: $idDocument, idChampsup:$idChampsup, valeurChamp:$valeurChamp ';
  }
}
