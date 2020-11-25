import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  final String defaultValue;
  final RegExp regExp;
  final String hintText;
  final String helperText;
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final String validationMessage;
  InputButton(
      {this.defaultValue,
      this.helperText,
      this.regExp,
      this.hintText,
      this.labelText,
      this.icon,
      this.validationMessage,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.redAccent,
          primaryColorDark: Colors.red,
        ),
        child: TextFormField(
          controller: controller..text = defaultValue,
          validator: (value) {
            if (value.isEmpty || !regExp.hasMatch(value)) {
              return validationMessage;
            }
            return null;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
              hintText: hintText,
              helperText: helperText,
              labelText: labelText,
              prefixIcon: Icon(
                icon,
                color: Colors.red,
              ),
              prefixText: ' ',
              suffixText: '?',
              suffixStyle: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
