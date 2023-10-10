import 'package:flutter/material.dart';

class IconesTreino extends StatelessWidget {
  final Icon icone;
  final String hintText;
  final String informacao;

  const IconesTreino({
    super.key,
    required this.hintText,
    required this.icone,
    required this.informacao,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 120,
        height: 150,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            icone,
            const SizedBox(height: 8),
            Text(
              hintText,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 2),
            Text(
              informacao,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
