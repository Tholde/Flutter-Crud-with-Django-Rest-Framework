import 'package:flutter/material.dart';

import '../services/api_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  final _tokenController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isReset = false;

  void _sendLink() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ApiService().sendResetPassword(_emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Link sended')),
        );
        setState(() {
          _isReset = true;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error : ${e.toString()}')),
        );
      }
    }
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ApiService().resetPassword(
          _tokenController.text,
          _passwordController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reset Password Successfuly')),
        );
        Navigator.pop(context); // Retourner à l'écran de connexion
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error : ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isReset ? 'Reset Password' : 'Link',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (!_isReset) ...[
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(labelText: 'Email'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _sendLink,
                            child: Text('Envoyer le lien de réinitialisation'),
                          ),
                        ] else ...[
                          TextFormField(
                            controller: _tokenController,
                            decoration: InputDecoration(
                                labelText: 'Token de réinitialisation'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ce champ est requis';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                labelText: 'Nouveau mot de passe'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ce champ est requis';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _resetPassword,
                            child: Text('Réinitialiser le mot de passe'),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
