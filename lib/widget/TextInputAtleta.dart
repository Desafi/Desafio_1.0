import 'package:desafio/model/atleta.dart';
import 'package:flutter/material.dart';

class TextInputAtleta extends StatelessWidget {
  final String hintText;
  final Atleta atleta;

  const TextInputAtleta({
    super.key,
    required this.hintText,
    required this.atleta,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Este campo é obrigatório!";
        }
        atleta.numeroDoCelular = value;
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.phone),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
        fillColor: Colors.grey[200],
        filled: true,
        border: const OutlineInputBorder(),
        labelText: 'Número de celular',
        labelStyle: const TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }
}
