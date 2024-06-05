import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final String userID;
  final String imageURL;

  UserPage({required this.userID, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageURL),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Welcome, $userID',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
