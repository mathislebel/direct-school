import 'dart:convert';
import 'package:http/http.dart' as http;

class DatabaseService {
  final String baseUrl = 'http://10.0.2.2:8090';

  Future<List<Score>> getUserScores(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/collections/scores/records?filter=(user_id="$userId")'));

    print('Requête URL: ${response.request!.url}');
    print('Code de réponse: ${response.statusCode}');
    print('Corps de réponse: ${response.body}');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['items'];
      print('Scores récupérés: $jsonResponse'); // Débogage
      return jsonResponse.map((data) => Score.fromJson(data)).toList();
    } else {
      print('Erreur lors de la récupération des scores: ${response.body}');
      throw Exception('Failed to load scores');
    }
  }
}

class Score {
  final String exam;
  final String date;
  final String activity;
  final int percentage;
  final int points;

  Score({
    required this.exam,
    required this.date,
    required this.activity,
    required this.percentage,
    required this.points,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      exam: json['exam'],
      date: json['date'],
      activity: json['activity'],
      percentage: json['percentage'],
      points: json['points'],
    );
  }
}
