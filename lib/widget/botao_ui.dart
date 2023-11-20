import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoUI extends StatelessWidget {
  final String hintText;
  final Widget icone;
  final Color? cor;
  final Function()? onTap;

  const BotaoUI({
    super.key,
    required this.hintText,
    required this.icone,
    required this.cor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: cor,
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(50)),
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icone,
              const SizedBox(
                width: 50,
              ),
              Text(
                hintText,
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
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
