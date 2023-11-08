import 'package:flutter/material.dart';

class TextFormFieldCadastro extends StatelessWidget {
  final String labelText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? formController;


  const TextFormFieldCadastro({
    super.key,
    required this.labelText,
    this.formController,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: formController,
        onChanged: onChanged,
        validator: validator,
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
