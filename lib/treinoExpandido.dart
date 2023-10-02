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
    return MaterialApp(
      home: TelaExpandidaApp(),
    );
  }
}

class TelaExpandidaApp extends StatefulWidget {
  const TelaExpandidaApp({super.key});

  @override
  State<TelaExpandidaApp> createState() => _TelaExpandidaAppState();
}

class _TelaExpandidaAppState extends State<TelaExpandidaApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFebf5f6),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              Text(
                'Informações da prova',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text('Aqui mostra uma descrição detalhada sobre sua prova:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120,
                    height: 150,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Icon(
                          Icons.date_range_outlined,
                          size: 50,
                          color: Color(0xFF51b9b1),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Data do treino:',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '12/05/2023',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 150,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Icon(
                          Icons.pool_outlined,
                          size: 50,
                          color: Color(0xFF51b9b1),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tipo:',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Crawl',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 150,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Icon(
                          Icons.punch_clock_outlined,
                          size: 50,
                          color: Color(0xFF51b9b1),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tempo da prova:',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '25:00:00',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120,
                    height: 150,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Icon(
                          Ionicons.heart,
                          size: 50,
                          color: Color(0xFF51b9b1),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Batimento início:',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '100 bpm',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 150,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Icon(
                          Ionicons.heart_circle_sharp,
                          size: 50,
                          color: Color(0xFF51b9b1),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Batimento final:',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '150 bpm',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 150,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Icon(
                          Ionicons.timer_sharp,
                          size: 50,
                          color: Color(0xFF51b9b1),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Maior tempo:',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '01:50.20',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120,
                    height: 150,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Icon(
                          Ionicons.time_sharp,
                          size: 50,
                          color: Color(0xFF51b9b1),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Menor tempo:',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '01:20.20',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                'Voltas',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.0),
              Container(
                width: 400.0,
                height: 400.0,
                decoration: BoxDecoration(
                  color: Color(0xFFd3dfe4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Alinhar à esquerda
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Volta 1',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          Text('01:05.05',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          Text('01:05.05',
                              style: const TextStyle(
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
    );
  }
}
