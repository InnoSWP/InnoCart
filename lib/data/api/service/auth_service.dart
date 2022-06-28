import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:innocart_front/data/api/service/profile_service.dart';
import 'package:innocart_front/data/data_storages/data_storage.dart';

class AuthService {
  Future<int> attemptLogIn(String username, String password) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/auth/token/login/');
    var res = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"username": username, "password": password}));
    if (res.statusCode == 200) {
      var token = jsonDecode(res.body);
      DataStorage.instance.saveToken(token["auth_token"]);
      ProfileService().getMyProfile();
    }
    return res.statusCode;
  }

  Future<int> attemptSignUp(
      String email, String username, String password) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/authusers/');
    var res = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "username": username,
          "password": password,
        }));
    return res.statusCode;
  }

  Future<bool> isStorageEmpty() async {
    return DataStorage.instance.isEmpty();
  }
}
