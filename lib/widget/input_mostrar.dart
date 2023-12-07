import 'package:flutter/material.dart';

class InputMostrar extends StatelessWidget {
  final String hintText;
  final String valor;

  const InputMostrar(
      {super.key,
      required this.hintText,
      required this.valor,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: false,
      initialValue: valor,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
        fillColor: Colors.grey[200],
        filled: true,
        border: const OutlineInputBorder(),
        labelText: hintText,
        labelStyle: const TextStyle(
          color: Colors.black54,
        ),
      ),
      style: const TextStyle(color: Colors.black87),
    );
  }
}
