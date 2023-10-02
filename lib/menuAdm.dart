import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AdmApp(),
    );
  }
}

class AdmApp extends StatefulWidget {
  const AdmApp({super.key});

  @override
  State<AdmApp> createState() => _AdmAppState();
}

class _AdmAppState extends State<AdmApp> {
  Widget PrimeiraImagem() {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: Text(
              'Criar contas',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 60,
              ),
            ),
          ),
          SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/atleta.png',
              width: 300,
              height: 177,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget SegundaImagem() {
    return Card(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/images/treinador.png',
          width: 300,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            PrimeiraImagem(),
            SizedBox(height: 50),
            SegundaImagem(),
          ],
        ),
      ),
    );
  }
}
