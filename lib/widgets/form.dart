import 'package:flutter/material.dart';
import 'package:iExist/controllers/user_controller.dart';

class SearchForm extends StatefulWidget {
  @override
  SearchFormState createState() {
    return SearchFormState(); 
  }
}

class SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  bool _isSearching = false;
  RegExp phoneNumber = RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$");
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

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
              controller: nameController,
              validator: (value) {
                if (value.isEmpty || !phoneNumber.hasMatch(value)) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  hintText: 'Phone number',
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
            child: !_isSearching
                ? ElevatedButton(
                    onPressed: () async {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _isSearching = true;
                        });
                        var user =
                            await UserController.getUser(nameController.text);
                        if (user != null) {
                          Navigator.pushNamed(context, '/result',
                              arguments: user);
                        } else {}
                        setState(() {
                          _isSearching = false;
                        });
                      }
                    },
                    child: Text('Find me', style: TextStyle(fontSize: 18)),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ]),
    );
  }
}
