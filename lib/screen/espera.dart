import 'package:desafio/main.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      home: Espera(),
    );
  }
}

class Espera extends StatefulWidget {
  const Espera({super.key});

  @override
  State<Espera> createState() => _EsperaState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _EsperaState extends State<Espera> {
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
                  'Dados em análise',
                  style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.black),
                  ),
                ),
                Lottie.asset('assets/images/esperando.json',
                    width: MediaQuery.of(context).size.width - 50),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Os treinadores estão validadando suas informações, por favor aguarde ou entra em contato com seu professor!',
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BotaoPrincipal(
                  hintText: "Sair",
                  radius: 32,
                  cor: Colors.red,
                  onTap: () {
                    _auth.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginApp()),
                        (route) => false);
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
