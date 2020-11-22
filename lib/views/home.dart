import 'package:flutter/material.dart';
import 'package:iExist/widgets/form.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        body: ListView(children: [
          Container(
            margin: EdgeInsets.only(top: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do You ?',
                  style: TextStyle(
                      color: Colors.orange[800],
                      fontSize: 48,
                      fontFamily: 'Leaguegothic'),
                ),
              ],
            ),
          ),
          SearchForm()
        ]));
  }
}
