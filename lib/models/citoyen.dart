class Citoyen {
   String idCitoyen;
   String matricule;
   bool ? active ;


  Citoyen(
      {required this.idCitoyen,
      required this.matricule,
      this.active,
      
      
      });

  factory Citoyen.fromJson(dynamic json) {
    return Citoyen(
        idCitoyen: json['idCitoyen'] as String,
        matricule: json['matricule'] as String,
        active: json['active'] as bool
        );
  }

  static List<Citoyen> citoyensFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Citoyen.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Citoyen { idCitoyen: $idCitoyen, matricule: $matricule, active:$active}';
  }
}