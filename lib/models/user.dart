class User {
  int? nni;
  String? userame;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  String? adresse;
  String? phone;

  User(
      {this.nni,
      this.userame,
      this.firstName,
      this.lastName,
      this.email,
      this.role,
      this.adresse,
      this.phone});

  factory User.fromJson(dynamic json) {
    return User(
      nni: json['nni'],
      userame: json['userame'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      adresse: json['adresse'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nni': nni,
      'userame': userame,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'adresse': adresse,
      'phone': phone,
    };
  }

  static List<User> usersFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return User.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Admin { nni: $nni, userame: $userame,firstName: $firstName, lastName: $lastName,email: $email, adresse: $adresse , phone:$phone}';
  }
}
