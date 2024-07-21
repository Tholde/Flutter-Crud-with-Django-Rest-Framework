import 'package:flutter/material.dart';
import 'package:untitled2/models/users.dart';

import '../services/api_service.dart';

class UpdateUserScreen extends StatefulWidget {
  final int user_id;

  UpdateUserScreen({required this.user_id});

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  late Future<Users> _user;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _first_nameController;
  late TextEditingController _last_nameController;
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _user = ApiService().getUser(widget.user_id);
  }

  void _updateUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ApiService().updateUser(
          widget.user_id,
          Users(
              id: widget.user_id,
              first_name: _first_nameController.text,
              last_name: _last_nameController.text,
              username: _usernameController.text,
              email: _emailController.text,
              password: _passwordController.text),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update user')),
      body: FutureBuilder<Users>(
        future: _user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('not users'));
          } else {
            final user = snapshot.data!;
            _first_nameController =
                TextEditingController(text: user.first_name);
            _last_nameController = TextEditingController(text: user.last_name);
            _usernameController = TextEditingController(text: user.username);
            _passwordController = TextEditingController(text: user.password);
            _emailController = TextEditingController(text: user.email);
            return Padding(
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
                          return 'Firstname is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _last_nameController,
                      decoration: InputDecoration(labelText: 'Lastname'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lastname is required';
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
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
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
                      onPressed: _updateUser,
                      child: Text('Save update'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
