
class Score {
  final String exam;
  final String date;
  final String activity;
  final int percentage;
  final int points;

  Score({required this.exam, required this.date, required this.activity, required this.percentage, required this.points});

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
