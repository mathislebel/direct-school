import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminData {
  final String name;

  AdminData({required this.name});
}

class AdminServiceData {
  Future<AdminData> getAdminData(String userID) async {
    final url = Uri.parse('http://10.0.2.2:8090/api/collections/AUTH_admin/records?filter=user="$userID"');
    final response = await http.get(url, headers: {'Accept': 'application/json'});

    String userName = '';
    String imageURL = '';

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<dynamic> records = jsonResponse['items'];

      if (records.isNotEmpty) {
        var record = records.first;
        userName = record['user'];
        String imagePath = record['images'];

        return AdminData(
          name: userName,
        );
      } else {
        throw Exception('Failed to load user data');
      }
    }

    throw Exception('Failed to load user data');
  }
}
