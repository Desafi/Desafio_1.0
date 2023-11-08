import 'package:flutter/material.dart';

class InputMostrarFoto extends StatelessWidget {
  final String hintText;
  final Function(String) showImageFunction;

  const InputMostrarFoto({
    super.key,
    required this.hintText,
    required this.showImageFunction, // Adicione este parâmetro
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showImageFunction('assets/images/person.jpg');
      },
      child: TextFormField(
        enabled: false,
        readOnly: true,
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
          suffixIcon: const Icon(
            Icons.image,
            color: Colors.blue,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        onTap: () {
          showImageFunction(
              'assets/images/person.jpg'); // Abre a imagem quando o campo é tocado
        },
      ),
    );
  }
}
