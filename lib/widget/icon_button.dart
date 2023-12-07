import 'package:flutter/material.dart';

class BotaoIcon extends StatelessWidget {
  final Function() onTap;

  const BotaoIcon({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: const Icon(Icons.remove_red_eye),
      iconSize: 30,
      style: const ButtonStyle(),
    );
  }
}
