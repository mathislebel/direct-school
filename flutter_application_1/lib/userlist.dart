import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {
  final List<Map<String, String>> users;

  UserListPage({required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text('User ID: ${user['id']}'),
            subtitle: Text('Password: ${user['password']}'),
          );
        },
      ),
    );
  }
}
