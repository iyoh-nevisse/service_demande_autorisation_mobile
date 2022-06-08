class Admin {
   String idAdmin;
   String matricule;
   String etablissement;


  Admin(
      {required this.idAdmin,
      required this.matricule,
      required this.etablissement,
      
      
      });

  factory Admin.fromJson(dynamic json) {
    return Admin(
        idAdmin: json['idAdmin'] as String,
        matricule: json['matricule'] as String,
        etablissement: json['etablissement:'] as String,
        );
  }

  static List<Admin> adminsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Admin.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Admin { idAdmin: $idAdmin, matricule: $matricule,etablissement: $etablissement}';
  }
}