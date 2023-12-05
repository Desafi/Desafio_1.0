import 'package:desafio/screen/comparar_atletas.dart';
import 'package:desafio/screen/estatistica.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: DesempenhoApp(),
//     );
//   }
// }

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
                  Text(
                    'Estatisticas',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 26),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Aqui você pode comparar seu desempenho com outros atletas ou análisar seus treinos:',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  BotaoPrincipal(
                      radius: 12,
                      hintText: 'Ver meu desempenho',
                      cor: Colors.blueAccent,
                      onTap: () async {
                        // await Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //       builder: (context) =>  EstatisticaApp()),
                        // );
                      }),
                  const SizedBox(height: 50),
                  BotaoPrincipal(
                    radius: 12,
                    hintText: 'Comparar',
                    cor: Colors.blueAccent,
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const CompararAtletaApp()),
                      );
                    },
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
