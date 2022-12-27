import 'package:flutter/material.dart';

class AddTextfield extends StatelessWidget {
  String hint;
  TextEditingController controller;
  TextInputType type;

  AddTextfield({
    required this.hint,
    required this.controller,
    this.type = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      keyboardType: type,
    );
  }
}