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
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Icon(Icons.arrow_forward_ios_sharp)
          ],
        ),
      ),
    );
  }
}
