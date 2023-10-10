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
            SizedBox(height: 8),
            icone,
            SizedBox(height: 8),
            Text(
              hintText,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 2),
            Text(
              informacao,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
