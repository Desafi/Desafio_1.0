import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      icon: Icon(Icons.remove_red_eye),
      iconSize: 30,
      style: ButtonStyle(),
    );
  }
}
