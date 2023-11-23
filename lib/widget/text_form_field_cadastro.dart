import 'package:flutter/material.dart';

class TextFormFieldCadastro extends StatelessWidget {
  final String labelText;
  final String? valorInicial;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? formController;

  const TextFormFieldCadastro({
    super.key,
    required this.labelText,
    this.valorInicial,
    this.formController,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: formController,
        onChanged: onChanged,
        validator: validator,
        initialValue: valorInicial,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
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
