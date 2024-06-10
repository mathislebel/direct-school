import 'package:http/http.dart' as http;
import 'dart:convert';

class DataUserService {
  Future<UserData> getUserData(String userID) async {
    final url = Uri.parse('http://10.0.2.2:8090/api/collections/AUTH_user/records?filter=user="$userID"');
    final response = await http.get(url, headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<dynamic> records = jsonResponse['items'];

      if (records.isNotEmpty) {
        var record = records.first;
        String userName = record['user'];
        String imagePath = record['images'];

        // Assurez-vous que l'URL de l'image est complète
        String imageURL = imagePath.startsWith('http')
            ? imagePath
            : 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/3slmtp51i1pxug1';

        if (userName == 'Séréna') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/ecfzxynzeps73o9/image_removebg_preview_N4R36phOvj.png?token='; // Remplacez 'URL_de_l_image_de_Serena' par l'URL réelle de l'image de Serena
        } else if (userName == 'Mathis') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/3slmtp51i1pxug1/image_removebg_preview_1_cJBu1sSVaC.png?token='; // Remplacez 'URL_de_l_image_de_Mathis' par l'URL réelle de l'image de Mathis
        } 


        return UserData(
          name: userName,
          imageURL: imageURL,
        );
      } else {
        throw Exception('User not found');
      }
    } else {
      throw Exception('Failed to load user data');
    }
  }
}

class UserData {
  final String name;
  final String imageURL;

  UserData({required this.name, required this.imageURL});

 
}


