import 'package:flutter/material.dart';

import '../routes.dart';

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.userList),
              child: Text('Users List'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.addUser),
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
