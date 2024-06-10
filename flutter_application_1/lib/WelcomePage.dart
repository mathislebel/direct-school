import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'userpage.dart';
import 'adminpage.dart'; // Assurez-vous d'importer votre page admin
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

    print('Bouton de connexion appuyé');  // Ligne de débogage

    // Utilisez l'URL correcte de votre API qui renvoie des données JSON
    final userUrl = Uri.parse('http://10.0.2.2:8090/api/collections/AUTH_user/records');
    final adminUrl = Uri.parse('http://10.0.2.2:8090/api/collections/AUTH_admin/records');
    print('URL de la requête (user): $userUrl');
    print('URL de la requête (admin): $adminUrl');

    // Ajoutez votre token d'authentification ici
    String authToken = 'f50xjob4te7lgwm'; // Remplacez par votre token

    final userResponse = await http.get(
      userUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',  // Ajoutez l'en-tête d'authentification si nécessaire
      },
    );

    final adminResponse = await http.get(
      adminUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',  // Ajoutez l'en-tête d'authentification si nécessaire
      },
    );

    print('Statut de la réponse (user): ${userResponse.statusCode}');  // Ligne de débogage
    print('Statut de la réponse (admin): ${adminResponse.statusCode}');  // Ligne de débogage

    if (userResponse.statusCode == 200) {
      var jsonResponse = json.decode(userResponse.body);
      List<dynamic> records = jsonResponse['items'];

      for (var record in records) {
        if (record['user'] == enteredUser && record['password'] == enteredPassword) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserPage(
                userID: enteredUser,
                imageURL: record['images'],
              ),
            ),
          );
          return;
        }
      }
    }

    if (adminResponse.statusCode == 200) {
      var jsonResponse = json.decode(adminResponse.body);
      List<dynamic> records = jsonResponse['items'];

      for (var record in records) {
        if (record['user'] == enteredUser && record['password'] == enteredPassword) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPage(
                userID: enteredUser,
              ),
            ),
          );
          return;
        }
      }
    }

    // Afficher un message d'erreur si la connexion échoue
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Identifiants invalides'),
    ));
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
                  hintText: 'Utilisateur',
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
                  hintText: 'Mot de passe',
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
                      onPressed: _login, // Utilisation de _login sans fonction anonyme
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF125432),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Continuer',
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
