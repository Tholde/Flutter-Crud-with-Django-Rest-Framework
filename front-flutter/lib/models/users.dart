class Users {
  int id;
  String first_name;
  String last_name;
  String username;
  String email;
  String password;

  Users(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.username,
      required this.email,
      required this.password});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        id: json['id'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        username: json['username'],
        email: json['email'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
