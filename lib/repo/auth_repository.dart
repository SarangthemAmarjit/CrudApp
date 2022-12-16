import 'dart:convert';
import 'dart:developer';
import 'package:crudapp/listener/auth_login_listener.dart';
import 'package:crudapp/modal/tokkenmodal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future login(
      {required String username,
      required String password,
      required AuthLoginListener authLoginListener}) async {
    authLoginListener.loading();

    final prefs = await SharedPreferences.getInstance();
    final body = {'username': username, 'password': password};
    final response = await http.post(
        Uri.parse('http://phpstack-598410-2859373.cloudwaysapps.com/api/login'),
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final tokken = tokkenmodal.fromJson(data);
      prefs.setString('tokken', tokken.token);
      authLoginListener.loaded();

      log('Successfully post Data');
    } else {
      log('Failed to PostData.');
      authLoginListener.error();
      log(response.statusCode.toString());
    }
  }
}
