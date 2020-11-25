import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iExist/models/User.dart';

class UserController {
  static var url = 'https://polar-basin-64651.herokuapp.com/api/users';
  static Future<User> getUser(name) async {
    var response =
        await http.get('$url/$name').timeout(const Duration(seconds: 9));
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      User user = User.fromJson(map);
      if (user.description == null) user.description = "No description";
      return user;
    }
    return null;

    //print(await http.read('https://example.com/foobar.txt'));
  }

  static Future<bool> createUser(User user) async {
    final response = await http.post(
      "$url",
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: user.toJson(),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
