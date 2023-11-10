import 'package:desafio/widget/icones_treino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TreinoExpandidoApp(),
    );
  }
}

class TreinoExpandidoApp extends StatefulWidget {
  const TreinoExpandidoApp({super.key});

  @override
  State<TreinoExpandidoApp> createState() => _TreinoExpandidoAppState();
}

class _TreinoExpandidoAppState extends State<TreinoExpandidoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebf5f6),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 75,
                ),
                const SizedBox(height: 30.0),
                const Text(
                  'Informações da prova',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                const Text(
                    'Aqui mostra uma descrição detalhada sobre sua prova:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconesTreino(
                      hintText: "Data do treino: ",
                      informacao: "12/05/2023",
                      icone: Icon(
                        Icons.date_range_outlined,
                        size: 50,
                        color: Color(0xFF51b9b1),
                      ),
                    ),
                    IconesTreino(
                        hintText: "Tipo",
                        informacao: "Crawl",
                        icone: Icon(
                          Icons.pool_outlined,
                          size: 50,
                          color: Color(0xFF51b9b1),
                        )),
                    IconesTreino(
                      hintText: "Tempo da prova: ",
                      informacao: "30:00:00",
                      icone: Icon(
                        Icons.punch_clock_outlined,
                        size: 50,
                        color: Color(0xFF51b9b1),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconesTreino(
                      hintText: "Batimento início: ",
                      informacao: "100 bpm",
                      icone: Icon(
                        Ionicons.heart,
                        size: 50,
                        color: Color(0xFF51b9b1),
                      ),
                    ),
                    IconesTreino(
                      hintText: "Batimento final: ",
                      informacao: "150 bpm",
                      icone: Icon(
                        Ionicons.heart_circle_sharp,
                        size: 50,
                        color: Color(0xFF51b9b1),
                      ),
                    ),
                    IconesTreino(
                      hintText: "Maior tempo ",
                      informacao: "01:50.20",
                      icone: Icon(
                        Ionicons.timer_sharp,
                        size: 50,
                        color: Color(0xFF51b9b1),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconesTreino(
                      hintText: "Menor tempo:: ",
                      informacao: "01:20.20",
                      icone: Icon(
                        Ionicons.time_sharp,
                        size: 50,
                        color: Color(0xFF51b9b1),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Voltas',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10.0),
                Container(
                  width: 400.0,
                  height: 400.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFd3dfe4),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Alinhar à esquerda
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Volta 1',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            Text('01:05.05',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            Text('01:05.05',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0), // Espaço entre os itens da lista
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}