import 'dart:convert';
import 'package:http/http.dart' as http;

class DatabaseService {
  final String baseUrl = 'http://10.0.2.2:8090';

  Future<UserData> getUserData(String userID) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8090/api/collections/users/records/$userID'));

    if (response.statusCode == 200) {
      return UserData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<List<Score>> getUserScores(String userID) async {
    final response = await http.get(Uri.parse('$baseUrl/api/collections/scores/records?filter=(user_id="$userID")'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['items'];
      return jsonResponse.map((data) => Score.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load scores');
    }
  }
}

class UserData {
  final String name;
  final String imageURL;

  UserData({required this.name, required this.imageURL});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      imageURL: json['imageURL'],
    );
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
