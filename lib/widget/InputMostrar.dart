import 'package:flutter/material.dart';

class InputMostrar extends StatelessWidget {
  final String hintText;

  const InputMostrar({
    super.key,
    required this.hintText,
  });

  Widget build(BuildContext context) {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(),
        labelText: hintText,
        labelStyle: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }
}
