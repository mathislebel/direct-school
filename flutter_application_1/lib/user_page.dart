import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserNotesPage extends StatefulWidget {
  final String userId; // Changer le nom de l'argument en userName

  const UserNotesPage({Key? key, required this.userId}) : super(key: key);

  @override
  _UserNotesPageState createState() => _UserNotesPageState();
}

class _UserNotesPageState extends State<UserNotesPage> {
  List<dynamic> notes = [];

  @override
  void initState() {
    super.initState();
    _fetchUserNotes(widget.userId); // Passer le nom d'utilisateur à la fonction de récupération des notes
  }

Future<void> _fetchUserNotes(String userName) async {
    String userId = '';
    if (userName == 'Séréna') {
      userId = 'ecfzxynzeps73o9'; // Remplacer 'ID_de_Séréna' par l'ID réel de Séréna
    } else if (userName == 'Mathis') {
      userId = '3slmtp51i1pxug1'; // Remplacer 'ID_de_Mathis' par l'ID réel de Mathis
    }

    try {
      final notesUrl = Uri.parse('http://10.0.2.2:8090/api/collections/notes/records?filter=user="$userId"');
      String authToken = 'f50xjob4te7lgwm';

      final response = await http.get(
        notesUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          notes = data['items'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Échec du chargement des notes'),
        ));
      }
    } catch (e) {
      print('Erreur lors de la récupération des données: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de la récupération des données'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes de l\'utilisateur'),
      ),
      body: notes.isEmpty
          ? Center(child: Text('Aucune note trouvée'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text('Exam: ${note['exam']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Exam: ${note['exam']}'),
                      Text('Date: ${note['date']}'),
                      Text('Activity: ${note['activity']}'),
                      if (note.containsKey('percentage'))
                        Text('Percentage: ${note['percentage']}%'),
                      Text('Points: ${note['points']}'),
                      Text('Comment: ${note['comment']}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
