import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iExist/router.dart';
import 'package:iExist/services/authservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: AuthService().handleAuth(),
    //initialRoute: '/auth',
    routes: routes,
  ));
}
