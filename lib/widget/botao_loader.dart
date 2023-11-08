import 'package:flutter/material.dart';

class BotaoLoader extends StatelessWidget {
  final Widget hintText;
  final Color cor;
  final Function()? onTap;

  BotaoLoader({
    super.key,
    required this.hintText,
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
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: hintText
        ),
      ),
    );
  }
}
