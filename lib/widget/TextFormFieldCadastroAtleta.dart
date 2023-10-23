import 'package:flutter/material.dart';

class TextFormFieldCadastroAtleta extends StatelessWidget {
  final String labelText;


  const TextFormFieldCadastroAtleta({
    super.key,
    required this.labelText,

  });

  @override
  Widget build(BuildContext context) => TextFormField(
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
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.black54,
          ),
        ),
      );
}
