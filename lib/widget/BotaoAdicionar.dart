import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoAdicionar extends StatelessWidget {
  final String hintText;
  final Function()? onTap;

  const BotaoAdicionar({
    super.key,
    required this.hintText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 50,
          width: 250,
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
                color: Colors.white,
              ),
              Text(
                hintText,
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
