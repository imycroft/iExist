import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iExist/services/authservice.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String phoneNo;
  String smsCode;
  String verificationId;

  Future<void> verifyPhone(phoneNumber) async {
    final PhoneCodeSent smsCodeSent = (verId, [int forceCodeResend]) {
      this.verificationId = verId;
      setState(() {});
      smsCodeDialog(context).then((value) {
        print('signed in');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verifiFailed = (e) {
      print('Walidation:${e.message}');
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (verId) {
      this.verificationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoTimeout,
        timeout: const Duration(seconds: 10));
  }

  Future<bool> smsCodeDialog(context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10),
            actions: [
              FlatButton(
                  onPressed: () {
                    AuthService().signInWithOTP(smsCode, verificationId);
                  },
                  child: Text('Done'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone auth')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Enter phone'),
                onChanged: (value) {
                  this.phoneNo = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  verifyPhone(phoneNo);
                },
                child: Text('Verify'),
                textColor: Colors.white,
                elevation: 7.0,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
