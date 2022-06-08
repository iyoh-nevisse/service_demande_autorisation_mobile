class Entreprise {
   String idEntreprise;
   String matricule;
   bool ? active ;


  Entreprise(
      {required this.idEntreprise,
      required this.matricule, 
      this.active,
      
      
      });

  factory Entreprise.fromJson(dynamic json) {
    return Entreprise(
        idEntreprise: json['idEntreprise'] as String,
        matricule: json['matricule'] as String,
        active: json['active'] as bool
        );
  }

  static List<Entreprise> entreprisesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Entreprise.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Entreprise { idEntreprise: $idEntreprise, matricule: $matricule, active:$active}';
  }
}