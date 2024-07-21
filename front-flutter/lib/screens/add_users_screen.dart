import 'package:flutter/material.dart';

import '../models/users.dart';
import '../services/api_service.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUsersScreenState createState() => _AddUsersScreenState();
}

class _AddUsersScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _first_nameController = TextEditingController();
  final _last_nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _createCrud() async {
    if (_formKey.currentState!.validate()) {
      await ApiService().createUser(
        Users(
            id: 0,
            first_name: _first_nameController.text,
            last_name: _last_nameController.text,
            username: _usernameController.text,
            email: _emailController.text,
            password: _passwordController.text),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _first_nameController,
                decoration: InputDecoration(labelText: 'Firstname'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'firstname is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _last_nameController,
                decoration: InputDecoration(labelText: 'Lastname'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'lastname is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _last_nameController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createCrud,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
