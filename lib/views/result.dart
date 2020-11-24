import 'package:flutter/material.dart';
import 'package:iExist/models/User.dart';

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.yellow,
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I FOUND YOU !',
                    style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 48,
                        fontFamily: 'Leaguegothic'),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Card(
                color: Colors.orangeAccent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        user.name.toUpperCase(),
                        style:
                            TextStyle(fontSize: 24, fontFamily: 'Leaguegothic'),
                      ),
                      subtitle: Text(user.description),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('EDIT'),
                          onPressed: () {/* ... */},
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('DELETE'),
                          onPressed: () {/* ... */},
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
