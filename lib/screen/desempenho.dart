import 'package:desafio/widget/BotaoPrincipal.dart';
import 'package:desafio/widget/CardResultado.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DesempenhoApp(),
    );
  }
}

class DesempenhoApp extends StatefulWidget {
  const DesempenhoApp({super.key});

  @override
  State<DesempenhoApp> createState() => _DesempenhoAppState();
}

class _DesempenhoAppState extends State<DesempenhoApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  Image.asset('assets/images/logoUnaerp.png', width: 200),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Desempenho',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 26),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Informações sobre o desempenho geral:',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset('assets/images/imagemGrafico.jpg', width: 400),
                  const SizedBox(height: 50),
                  CardTreino(
                      hint: "Tempo total percorrido", conteudo: "01:30:00"),
                  const SizedBox(height: 10),
                  CardTreino(
                      hint: "Média de tempo por volta", conteudo: "02:30:00"),
                  const SizedBox(height: 10),
                  CardTreino(
                      hint: "Frequência média em prova", conteudo: "120"),
                  const SizedBox(height: 10),
                  CardTreino(hint: "Frequência média parado", conteudo: "80"),
                  const SizedBox(height: 50),
                  BotaoPrincipal(
                    hintText: 'Comparar',
                    cor: Colors.blueAccent,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
