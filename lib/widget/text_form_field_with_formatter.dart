import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFormFieldWithFormatter extends StatelessWidget {
  final String mask;
  final String labelText;
  final String? valorInicial;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final FormFieldValidator<String>? validator;

  const TextFormFieldWithFormatter({
    super.key,
    required this.labelText,
    required this.mask,
    this.onChanged,
    this.valorInicial,
    this.decoration,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        inputFormatters: [
          MaskTextInputFormatter(
              mask: mask,
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy)
        ],
        initialValue: valorInicial,
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
