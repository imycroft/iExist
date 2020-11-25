import 'package:flutter/material.dart';
import 'package:iExist/controllers/user_controller.dart';
import 'package:iExist/models/User.dart';

import 'package:iExist/widgets/input_button.dart';

class AddPerson extends StatefulWidget {
  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final descController = TextEditingController();

  final RegExp phoneNumberReg =
      RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$");
  final RegExp userNameReg = RegExp(r"^([a-zA-Z]+\s{0,1}){1,3}$");

  bool _isAdding = false;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    phoneController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = ModalRoute.of(context).settings.arguments;
    final String userName =
        nameController.text.isEmpty ? "" : nameController.text;
    return Scaffold(
        backgroundColor: Colors.yellow,
        body: ListView(children: [
          Container(
            margin: EdgeInsets.only(top: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ADDING ...',
                  style: TextStyle(
                      color: Colors.orange[800],
                      fontSize: 48,
                      fontFamily: 'Leaguegothic'),
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Column(children: [
              InputButton(
                defaultValue: userName,
                controller: nameController,
                helperText: 'Don\'t be shy ;)',
                labelText: 'Enter the name',
                hintText: 'Username',
                icon: Icons.person,
                regExp: userNameReg,
                validationMessage: 'Please enter a valid user name',
              ),
              InputButton(
                defaultValue: phoneNumber,
                controller: phoneController,
                hintText: 'Phone number',
                helperText: 'Enter a valid phone number',
                labelText: 'Enter phone number',
                icon: Icons.phone,
                regExp: phoneNumberReg,
                validationMessage: 'Please enter a valid phone number',
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8, 32, 8, 0),
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.redAccent,
                    primaryColorDark: Colors.red,
                  ),
                  child: TextFormField(
                    controller: descController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        hintText: 'Quote',
                        helperText: 'Enter a short quote',
                        labelText: 'Enter a quote',
                        alignLabelWithHint: true),
                    keyboardType: TextInputType.multiline,
                    minLines: 5, //Normal textInputField will be displayed
                    maxLines: 5, // when user presses enter it will adapt to it
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8, 32, 8, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: !_isAdding
                      ? ElevatedButton(
                          onPressed: () async {
                            // Add Your Code here.
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _isAdding = true;
                              });
                              if (await UserController.createUser(User(
                                  name: nameController.text,
                                  phoneNumber: phoneController.text,
                                  description: descController.text))) {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Success :)"),
                                        content: Text(
                                            "This perons has been added,\nWould you like to add another?"),
                                        actions: [
                                          FlatButton(
                                            child: Text("Ok, Add another"),
                                            onPressed: () {
                                              nameController.clear();
                                              phoneController.clear();
                                              descController.clear();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text("No"),
                                            onPressed: () {
                                              Navigator.pushNamed(context, '/');
                                            },
                                          )
                                        ],
                                      );
                                    });
                                // Add Your Code here.

                              } else {
                                // Add Your Code here.
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Faillure :("),
                                        content: Text(
                                            "Error while adding this person"),
                                      );
                                    });
                              }
                              setState(() {
                                _isAdding = false;
                              });
                            }

                            // Validate returns true if the form is valid, otherwise false.
                          },
                          child: Text('Add it', style: TextStyle(fontSize: 18)),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ]),
          )
        ]));
  }
}
