import 'package:flutter/material.dart';

class AdminListPage extends StatelessWidget {
  final List<Map<String, String>> admins;

  AdminListPage({required this.admins});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin List'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: admins.length,
        itemBuilder: (context, index) {
          final admin = admins[index];
          return ListTile(
            title: Text('Admin ID: ${admin['id']}'),
            subtitle: Text('Password: ${admin['password']}'),
          );
        },
      ),
    );
  }
}
