import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Vazio extends StatelessWidget {
  const Vazio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Nenhum treino encontrado"),
            Lottie.asset('assets/images/carregamento.json'),
          ],
        ),
    );
  }
}
