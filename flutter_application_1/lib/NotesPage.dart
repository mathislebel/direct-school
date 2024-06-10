import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_page.dart'; // Assurez-vous d'importer la nouvelle page

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<dynamic> users = [];
  String? selectedUser;
  final TextEditingController _examController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _percentageController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final userUrl = Uri.parse('http://10.0.2.2:8090/api/collections/AUTH_user/records');
      String authToken = 'f50xjob4te7lgwm'; // Remplacez par votre token

      final response = await http.get(
        userUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          users = json.decode(response.body)['items'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Échec du chargement des utilisateurs'),
        ));
      }
    } catch (e) {
      print('Erreur lors du chargement des utilisateurs: $e');
    }
  }

  Future<void> _submitNote() async {
    try {
      final notesUrl = Uri.parse('http://10.0.2.2:8090/api/collections/notes/records');
      String authToken = 'f50xjob4te7lgwm'; // Remplacez par votre token

      final response = await http.post(
        notesUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode({
          'user': selectedUser,
          'exam': _examController.text,
          'date': _dateController.text,
          'activity': _activityController.text,
          'percentage': _percentageController.text,
          'points': _pointsController.text,
          'comment': _commentController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Note enregistrée avec succès'),
        ));
        _navigateToUserNotesPage();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Échec de l\'enregistrement de la note'),
        ));
      }
    } catch (e) {
      print('Erreur lors de l\'enregistrement de la note: $e');
    }
  }

  void _navigateToUserNotesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserNotesPage(userId: selectedUser!),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0]; // Formate la date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Sélectionnez un utilisateur',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                items: users.map<DropdownMenuItem<String>>((user) {
                  return DropdownMenuItem<String>(
                    value: user['id'],
                    child: Text(user['user']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedUser = value as String?;
                  });
                },
                value: selectedUser,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _examController,
                decoration: InputDecoration(
                  labelText: 'Exam',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _dateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _activityController,
                decoration: InputDecoration(
                  labelText: 'Activity',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _percentageController,
                decoration: InputDecoration(
                  labelText: 'Percentage',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _pointsController,
                decoration: InputDecoration(
                  labelText: 'Points',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF125432),
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Valider',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
