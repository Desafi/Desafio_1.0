import 'package:desafio/model/atleta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var cepFormatter = new MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var cpfFormatter = new MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var rgFormatter = new MaskTextInputFormatter(
    mask: '##.###.###-#',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var celularFormatter = new MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

class InputMostrar extends StatelessWidget {
  final String hintText;
  final Atleta atleta;
  final TextInputFormatter formater;
  final TextInputType tipo;

  const InputMostrar({
    super.key,
    required this.hintText,
    required this.atleta,
    required this.formater,
    required this.tipo,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: false,
      keyboardType: tipo,
      inputFormatters: [formater],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Este campo é obrigatório!";
        }
        atleta.numeroDoCelular = value;
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone),
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
