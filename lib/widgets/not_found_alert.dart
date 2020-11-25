import 'package:flutter/material.dart';

showTimeoutDialog(context) {
  Widget cancelButton = FlatButton(
    child: Text("Got it"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Are you in Africa?"),
    content:
        Text("Please check your internet connexion, or change your country."),
    actions: [
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog(context, phoneNumber) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("No, thanks"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Yes, add it"),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, '/add', arguments: phoneNumber);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Sorry :("),
    content: Text("I can\'t find this person, would you like to add it?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
