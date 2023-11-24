import 'package:desafio/widget/botao_principal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NaoEncontrado(),
    );
  }
}

class NaoEncontrado extends StatefulWidget {
  const NaoEncontrado({super.key});

  @override
  State<NaoEncontrado> createState() => _NaoEncontradoState();
}

class _NaoEncontradoState extends State<NaoEncontrado> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Erro ao procurar atleta',
                  style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.black),
                  ),
                ),
                Lottie.asset('assets/images/animacao.json',
                    width: MediaQuery.of(context).size.width - 50),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'O atleta não terminou de preencher as informações, por favor contate e peça para que preencha!',
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                BotaoPrincipal(
                  radius: 12,
                  hintText: 'Voltar',
                  cor: Colors.blue,
                  onTap: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
