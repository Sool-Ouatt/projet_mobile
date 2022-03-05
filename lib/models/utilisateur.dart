class Utilisateur {
  late int id;
  late String username;
  late String email;
  late String telephone;
  late String password = "passWord";

  Utilisateur({
    required this.id,
    required this.username,
    required this.email,
    required this.telephone,
  });

  setPassWord(pword) {
    this.password = pword;
  }

  @override
  String toString() =>
      'Utilisateur(id: $id, username: $username, email: $email, telephone: $telephone)';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'telephone': telephone,
    };
  }

  Utilisateur.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? json['id'],
        username = json['username'] ?? json['username'],
        email = json['email'] ?? json['email'],
        telephone = json['telephone'] ?? json['telephone'];
}
