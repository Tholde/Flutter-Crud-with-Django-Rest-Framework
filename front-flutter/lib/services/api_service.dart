import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/users.dart';

class ApiService {
  final String baseUrl = 'http://localhost:8000/api';

  // CRUD Operations
  Future<List<Users>> getAllUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users/'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Users.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load cruds');
    }
  }

  Future<Users> getUser(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode == 200) {
      return Users.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load crud');
    }
  }

  Future<void> createUser(Users users) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(users.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create crud');
    }
  }

  Future<void> updateUser(int id, Users users) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(users.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update crud');
    }
  }

  Future<void> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete crud');
    }
  }

  // Auth Operations
  Future<void> register(String firstname, String lastname, String username,
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'first_name': firstname,
        'last_name': lastname,
        'username': username,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    }
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid email or password');
    } else {
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }

  Future<void> sendResetPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/password-reset/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    if (response.statusCode != 200) {
      throw Exception('Échec de l\'envoi du lien de réinitialisation');
    }
  }

  Future<void> resetPassword(String token, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/password/reset'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token, 'password': password}),
    );
    if (response.statusCode != 200) {
      throw Exception('Échec de la réinitialisation du mot de passe');
    }
  }
}
