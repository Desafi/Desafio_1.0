import 'package:flutter/material.dart';

class TextFormFieldFoto extends StatelessWidget {
  final String hint;
  final Function()? onTap;
  final FormFieldValidator<String>? validator;

  const TextFormFieldFoto({
    super.key,
    required this.hint,
    this.onTap,
    this.validator,

  });

  @override
  Widget build(BuildContext context) => TextFormField(
        readOnly: true,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.image),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          fillColor: Colors.grey[200],
          filled: true,
          border: const OutlineInputBorder(),
          labelText: hint,
          labelStyle: const TextStyle(
            color: Colors.black54,
          ),
        ),
        onTap: onTap,
      );
}
