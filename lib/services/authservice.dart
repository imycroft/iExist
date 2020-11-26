import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:iExist/views/home.dart';
import 'package:iExist/views/phone_auth.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return Home();
          } else {
            return HomePage();
          }
        });
  }

  signIn(AuthCredential authCreds) {
    print('signed in Cred:!${authCreds.token}');

    FirebaseAuth.instance
        .signInWithCredential(authCreds)
        .catchError(() => print('code error !'));
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCredential);
  }
}
