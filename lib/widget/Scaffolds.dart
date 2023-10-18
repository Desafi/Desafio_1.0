import 'package:flutter/material.dart';

void mostrarErro(BuildContext context, String nome, Color cor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(nome),
      backgroundColor: cor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      elevation: 30,
    ),
  );
}

void mostrarSucesso(BuildContext context, String nome, Color cor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(nome),
      backgroundColor: cor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      elevation: 30,
    ),
  );
}
