import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoCronometro extends StatelessWidget {
  final String hintText;
  final IconData icone;
  final Color? cor;
  final Function()? onTap;

  const BotaoCronometro({
    super.key,
    required this.hintText,
    required this.cor,
    this.onTap,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icone,
                color: Colors.white,
              ),
              Text(
                hintText,
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
