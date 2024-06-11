import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'agendapage.dart';
import 'notespage.dart';

class AdminPage extends StatelessWidget {
  final String userID;

  AdminPage({required this.userID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Admin, $userID',
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage()));
                },
                child: Text('Notes'),
              ),
              SizedBox(height: 20.0),
              CreateEventForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateEventForm extends StatefulWidget {
  @override
  _CreateEventFormState createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        final now = DateTime.now();
        final dt = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        final format = MaterialLocalizations.of(context).formatTimeOfDay(picked);
        controller.text = DateFormat('HH:mm').format(dt);
      });
  }

  void _createEvent() async {
    try {
      final url = Uri.parse('http://10.0.2.2:8090/api/collections/agenda/records');
      String authToken = 'f50xjob4te7lgwm';

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode({
          'title': _titleController.text,
          'description': _descriptionController.text,
          'date': _dateController.text,
          'startTime': _startTimeController.text,
          'endTime': _endTimeController.text,
          'location': _locationController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Événement créé avec succès');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Événement créé avec succès'),
        ));
        _clearForm();
      } else {
        print('Erreur de création de l\'événement: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Échec de la création de l\'événement'),
        ));
      }
    } catch (e) {
      print('Erreur lors de la création de l\'événement: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de la création de l\'événement'),
      ));
    }
  }

  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
    _startTimeController.clear();
    _endTimeController.clear();
    _locationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(labelText: 'Titre'),
        ),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(labelText: 'Description'),
        ),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _selectTime(context, _startTimeController),
          child: AbsorbPointer(
            child: TextField(
              controller: _startTimeController,
              decoration: InputDecoration(labelText: 'Heure de début'),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _selectTime(context, _endTimeController),
          child: AbsorbPointer(
            child: TextField(
              controller: _endTimeController,
              decoration: InputDecoration(labelText: 'Heure de fin'),
            ),
          ),
        ),
        TextField(
          controller: _locationController,
          decoration: InputDecoration(labelText: 'Lieu'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _createEvent,
          child: Text('Créer l\'événement'),
        ),
      ],
    );
  }
}
