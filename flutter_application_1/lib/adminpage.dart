import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/NotesPage.dart';

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
        child:Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( 
              'Welcome Admin, $userID',
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage()));
              }, 
              child: Text('Notes'))
          ],

        ),
        ),
      ),
    );
  }
}
