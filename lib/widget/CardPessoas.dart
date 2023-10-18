import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPessoas extends StatelessWidget {
  final String nome;
  final String? telefone;
  final Function()? onTap;

  CardPessoas({
    super.key,
    required this.nome,
    this.telefone,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          width: 400,
          height: 100,
          decoration: BoxDecoration(
              color: const Color(0xFFF7F2FA),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/person.jpg'),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Nome: $nome', style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: telefone != null,
                      child: Text('Telefone $telefone',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
