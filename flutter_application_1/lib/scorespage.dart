import 'package:flutter/material.dart';
import 'pocket_bases.dart';

class ScorePage extends StatelessWidget {
  final String userID;

  ScorePage({required this.userID});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Score>>(
      future: DatabaseService().getUserScores(userID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Center(child: Text('Erreur: ${snapshot.error}')),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // Afficher les données une fois qu'elles sont récupérées avec succès
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scores',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    DataTable(
                      columns: [
                        DataColumn(label: Text('EXAM')),
                        DataColumn(label: Text('DATE')),
                        DataColumn(label: Text('ACTIVITY')),
                        DataColumn(label: Text('%')),
                        DataColumn(label: Text('POINTS')),
                      ],
                      rows: snapshot.data!.map((score) {
                        return DataRow(
                          cells: [
                            DataCell(Text(score.exam)),
                            DataCell(Text(score.date)),
                            DataCell(Text(score.activity)),
                            DataCell(Text(score.percentage.toString())),
                            DataCell(Text(score.points.toString())),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Center(child: Text('Aucun score trouvé')),
          );
        }
      },
    );
  }
}
