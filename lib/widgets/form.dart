import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  @override
  SearchFormState createState() {
    return SearchFormState();
  }
}

class SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(children: [
          Container(
            margin: EdgeInsets.fromLTRB(16, 24, 16, 0),
            child: Theme(
              data: ThemeData(
                primaryColor: Colors.redAccent,
                primaryColorDark: Colors.red,
              ),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)),
                    hintText: 'Username',
                    helperText: 'It\'s just a joke, why so serious ?',
                    labelText: 'Check if you exist',
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.red,
                    ),
                    prefixText: ' ',
                    suffixText: '?',
                    suffixStyle: const TextStyle(color: Colors.red)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(8, 32, 8, 0),
            child: SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('I\'m searching for you')));
                  }
                },
                child: Text('Find me', style: TextStyle(fontSize: 18)),
              ),
            ),
          )
        ]));
  }
}
