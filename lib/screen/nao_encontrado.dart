import 'package:desafio/main.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Espera(),
//     );
//   }
// }

class NaoEncontradoTreino extends StatefulWidget {
  const NaoEncontradoTreino({super.key});

  @override
  State<NaoEncontradoTreino> createState() => _NaoEncontradoTreinoState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _NaoEncontradoTreinoState extends State<NaoEncontradoTreino> {
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
                  'Não encontrado',
                  style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.black),
                  ),
                ),
                Lottie.asset('assets/images/lupaVazio.json',
                    width: MediaQuery.of(context).size.width - 50),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Não foi possivel localizar um treino com a data passada!',
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BotaoPrincipal(
                  hintText: "Voltar",
                  radius: 32,
                  cor: Colors.amber,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
