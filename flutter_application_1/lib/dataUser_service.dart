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

        // Déterminez l'URL de l'image en fonction du nom de l'utilisateur
        if (userName == 'Séréna') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/ecfzxynzeps73o9/image_removebg_preview_N4R36phOvj.png?token='; // Remplacez 'URL_de_l_image_de_Serena' par l'URL réelle de l'image de Serena
        } else if (userName == 'Mathis') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/3slmtp51i1pxug1/image_removebg_preview_1_cJBu1sSVaC.png?token='; // Remplacez 'URL_de_l_image_de_Mathis' par l'URL réelle de l'image de Mathis
        } else if (userName == 'Enzo') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/om9jz22xydpof5z/image_14_XumheXb7ks.png?token=';
        } else if (userName == 'Wilfried') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/1nh0daox5io17d5/screenshot_2024_01_29_121801_1C3IGRVnoX.png?token=';
        } else if (userName == 'Mattéo') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/bn2a4kr13t9b2qg/image_11_uzA7bYHkSy.png?token=';
        } else if (userName == 'Vivien') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/5tmcljvqpun364v/image_12_IAnGvrW3yZ.png?token=';
        } else if (userName == 'Habi') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/0fnm582nvvhbqi7/image_13_EuHvlmIiIQ.png?token=';
        } else if (userName == 'Elone') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/0u55sualpyg3wxq/image_15_6NbSIHX0zm.png?token=';
        } else if (userName == 'Abderrazaq') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/v5nn7gv2hfschpg/image_16_1Rf9W4MBgc.png?token=';
        }  else if (userName == 'Salaheddine') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/4kjpyhof3vlxabt/image_17_c6mcPYo8xD.png?token=';
        }  else if (userName == 'Malo') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/gwom6tgkffobjpc/image_18_USKoIDIEEi.png?token=';
        } else if (userName == 'Grégory') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/rl2mqoot1utmee7/image_19_TzX3VrnA7r.png?token=';
        } else if (userName == 'Seiv') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/dso4lkhgkmcm72f/image_20_94hElcRGLV.png?token=';
        } else if (userName == 'Antoine') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/q81vzdix8ytgow9/image_21_iGa2EJfe6n.png?token=';
        } else if (userName == 'Paul') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/h5qka2jv3skf472/image_23_KiaZJLuRve.png?token=';
        } else if (userName == 'Mathias') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/moqop37tlp7vxwu/kkePKhJE4UrA_H3BubMu9pp.png?token=';
        } else if (userName == 'Lucas') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/dh9q2p7nvigk4hc/screenshot_2024_01_29_121335_ANtM8ifCnP.png?token=';
        } else if (userName == 'Rémy') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/7lymfizl3a7zzn2/screenshot_2024_01_29_121701_dQ5yZElnj2.png?token=';
        } else if (userName == 'Maxime') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/esflel4mfh04xp7/screenshot_2024_02_01_145418_alDG1Xz30u.png?token=';
        } else if (userName == 'Lucas A') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/oqu2mf7yz8cvrc9/image_2024_06_06_090509075_kCkZ1AOCzr.png?token=';
        } else if (userName == 'Clémentine') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/wws69yvx75vkcw4/image_2024_06_06_090806068_GpIbSdxnIw.png?token=';
        } else if (userName == 'Thibaud') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/x2go3tk3qz8p6yt/image_2024_06_06_091326131_cHY2PQixzb.png?token=';
        } else if (userName == 'Alexis') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/u8gcvv7d48jtk9f/image_2024_06_06_091554488_sZTsG0HMD2.png?token=';
        } else if (userName == 'Mathis K') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/ai2qbuzsl04koii/image_2024_06_06_092310863_lx2sid5o1c.png?token=';
        } else if (userName == 'Victor') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/13bwf0iqhwdywv4/image_2024_06_06_092610155_T5imCBBBdv.png?token=';
        } else if (userName == 'Aurélien') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/m4v63f8jq7phxcb/image_2024_06_06_093004112_uclepBLlh8.png?token=';
        } else if (userName == 'Laurent') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/2qlim1y7bc1jp24/image_2024_06_06_093355102_7BCRhHfKzr.png?token=';
        } else if (userName == 'Benoît') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/vm092g84bu1ngff/image_2024_06_06_093717492_Cvy8YpWT5Y.png?token=';
        } else if (userName == 'Max') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/ru1xzfqovt7oc5j/image_2024_06_06_094552000_H4L4ff8BOc.png?token=';
        } else if (userName == 'Michel') {
          imageURL = 'http://10.0.2.2:8090/api/files/r9ludsa7ehoweyr/0h7y6gd163q48mp/image_2024_06_06_094812441_QGfsB4VjOz.png?token=';
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


