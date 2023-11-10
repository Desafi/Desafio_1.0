import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/meus_users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MenuGerencia(),
//     );
//   }
// }

FirebaseFirestore db = FirebaseFirestore.instance;

class MenuGerencia extends StatefulWidget {
  const MenuGerencia({super.key});

  @override
  State<MenuGerencia> createState() => _MenuGerenciaState();
}

class _MenuGerenciaState extends State<MenuGerencia> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF42A5F5),
            title: const Text('Gerencie usuarios'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Treinador',
                ),
                Tab(
                  text: 'Atleta',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              MeusUsers(
                  visivel: false,
                  titulo: 'Treinador',
                  hintInput: 'Digite o nome do treinador..'),
              MeusUsers(
                  visivel: false,
                  titulo: 'Atletas',
                  hintInput: 'Digite o nome do atleta..'),
            ],
          ),
        ),
      ),
    );
  }
}
