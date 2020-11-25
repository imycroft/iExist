import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String phoneNo;
  String smsCode;
  String verificationId;

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (verID) {
      this.verificationId = verID;
    };

    final PhoneCodeSent smsCodeSent = (verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('signed in');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (user) {
      print('verified');
    };

    final PhoneVerificationFailed verifiFailed = (e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve,
        timeout: const Duration(seconds: 5));
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
                    var user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/');
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  },
                  child: Text('Done'))
            ],
          );
        });
  }

  signIn() {
    FirebaseAuth.instance.signInWithPhoneNumber(phoneNo).then((user) {
      Navigator.of(context).pushReplacementNamed('/');
    }).catchError((e) {
      print(e);
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
                onPressed: verifyPhone,
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
