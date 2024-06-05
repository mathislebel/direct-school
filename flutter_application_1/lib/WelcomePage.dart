import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'userpage.dart';
import 'widget/DelayAnimation.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
  String enteredUser = _userController.text;
  String enteredPassword = _passwordController.text;

  print('Login button pressed');  // Debugging line
  final response = await http.get(
    Uri.parse('http://192.168.153.19:8090/api/collections/AUTH/records'),  // Replace with your machine's IP
  );

  print('Response status: ${response.statusCode}');  // Debugging line
  print('Response body: ${response.body}');  // Debugging line

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List<dynamic> records = jsonResponse['items']; // Ensure you are accessing the correct structure

    for (var record in records) {
      if (record['user'] == enteredUser && record['password'] == enteredPassword) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserPage(
              userID: enteredUser,
              imageURL: record['images'],  // Assuming 'images' is the key for the image URL
            ),
          ),
        );
        return;
      }
    }

    // Show error message if login fails
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Invalid credentials'),
    ));
  } else {
    throw Exception('Failed to load records');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _userController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'User',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              DelayedAnimation(
                delay: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF125432),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
