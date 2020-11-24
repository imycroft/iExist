import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iExist/models/User.dart';

class UserController {
  static var url = 'https://polar-basin-64651.herokuapp.com/api/users';
  static Future<User> getUser(name) async {
    var response = await http.get('$url/$name');
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return User.fromJson(map);
    }
    return null;

    //print(await http.read('https://example.com/foobar.txt'));
  }
}
