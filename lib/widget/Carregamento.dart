import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Carregamento extends StatelessWidget {
  Carregamento({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LoadingAnimationWidget.inkDrop(
          color: Colors.black,
          size: 200
          ),
      ),
    );
  }
}
