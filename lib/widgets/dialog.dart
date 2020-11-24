import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String description;
  SearchResult({this.phoneNumber, this.name, this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: ListView(
        children: [
          Text('Name: $name'),
          Text('Phone number: $phoneNumber'),
          Text('Quote: $description')
        ],
      ),
    );
  }
}
