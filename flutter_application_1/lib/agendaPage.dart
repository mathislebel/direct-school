import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  List<dynamic> events = [];

  @override
  void initState() {
    super.initState();
    _fetchAgenda();
  }

  Future<void> _fetchAgenda() async {
    try {
      final eventsUrl = Uri.parse('http://10.0.2.2:8090/api/collections/agenda/records');
      String authToken = 'f50xjob4te7lgwm';

      final response = await http.get(
        eventsUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Données reçues: $data'); // Impression des données reçues
        setState(() {
          events = data['items'];
        });
      } else {
        print('Erreur de chargement des événements: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Échec du chargement des événements'),
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
        title: Text('Agenda'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: events.isEmpty
          ? Center(child: Text('Aucun événement trouvé'))
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  title: Text(event['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description: ${event['description']}'),
                      Text('Date: ${event['date']}'),
                      Text('Heure de début: ${event['startTime']}'),
                      Text('Heure de fin: ${event['endTime']}'),
                      Text('Lieu: ${event['location']}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
