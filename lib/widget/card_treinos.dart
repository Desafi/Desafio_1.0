import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardTreinos extends StatelessWidget {
  final String? nome;
  final String estilo;
  final String data;
  final Function()? onTap;

  const CardTreinos({
    super.key,
    this.nome,
    required this.estilo,
    required this.data,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/person.jpg'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(nome.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Estilo: $estilo',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(data, style: const TextStyle(fontSize: 11)),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
