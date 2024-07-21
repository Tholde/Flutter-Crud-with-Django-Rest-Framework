import 'package:flutter/material.dart';
import 'package:untitled2/models/users.dart';

import '../services/api_service.dart';

class UsersListScreen extends StatefulWidget {
  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final ValueNotifier<List<Users>> _usersNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      final users = await ApiService().getAllUsers();
      _usersNotifier.value = users;
    } catch (e) {}
  }

  Future<void> _deleteUser(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure to delete this ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await ApiService().deleteUser(id);
        _loadUsers();
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
      appBar: AppBar(title: Text('Users List')),
      body: ValueListenableBuilder<List<Users>>(
        valueListenable: _usersNotifier,
        builder: (context, users, child) {
          if (users.isEmpty) {
            return Center(child: Text('no utilisateur'));
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 5.0,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text('${user.first_name} ${user.last_name}',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  subtitle: Text('Contact: ${user.email}',
                      style: TextStyle(fontSize: 16.0)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/modcrud',
                          arguments: user.id,
                        ).then((_) => _loadUsers()),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteUser(user.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, '/add').then((_) => _loadUsers()),
        child: Icon(Icons.add),
      ),
    );
  }
}
