import 'package:flutter/material.dart'; // Assurez-vous que vous importez bien UserNotesPage
import 'package:flutter_application_1/user_page.dart';

import 'dataUser_service.dart';

class UserPage extends StatelessWidget {
  final String userID;
  final String imageURL;

  UserPage({required this.userID, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserData>(
      future: DataUserService().getUserData(userID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Center(child: CircularProgressIndicator()), // Indicateur de chargement
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Center(child: Text('Erreur: ${snapshot.error}')), // Afficher l'erreur si la récupération échoue
          );
        } else {
          // Afficher les données une fois qu'elles sont récupérées avec succès
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data!.imageURL),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${snapshot.data!.name}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Your score is ',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'ALGOSUP’s point system is very different from what is used in high-school or academia in general. The main reason is that we want to measure the distance between your current skills and what will be expected of you in a professional environment. We express that distance as a percentage of completion, 100% being what would be expected of a junior software engineer in its first job. Points are split between 8 different categories and since we don’t expect our students to be perfect, 50% in each categories is sufficient to be presented to a graduation jury at the end of your cursus. Do not try to convert points into the system you know, you will inevitably be disappointed. 10% is absolutely not equivalent to 2/20 ! 10% (or more) is where you should be after a year in a 5 year curriculum. The system has been designed to measure rather than reward and to encourage both perseverance and risk taking. Half of your points will be an average of your scores (persistence) and half will only take into account your best performance (risk taking). So 20% and then 80% is better than 50% twice.',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 20,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserNotesPage(userId: userID),
                          ),
                        );
                      },
                      child: Text('Scores'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
