import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoPrincipal extends StatelessWidget {
  final String hintText;
  final Color? cor;
  final double radius;
  final Function()? onTap;

  const BotaoPrincipal({
    super.key,
    required this.hintText,
    required this.radius,
    required this.cor,
    this.onTap,
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
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Text(
            hintText,
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
