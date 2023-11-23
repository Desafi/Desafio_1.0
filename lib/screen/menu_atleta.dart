import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/cadastro_atleta.dart';
import 'package:desafio/screen/desempenho.dart';
import 'package:desafio/screen/editar_atleta.dart';
import 'package:desafio/screen/espera.dart';
import 'package:desafio/screen/form_pre_treino.dart';
import 'package:desafio/screen/Treinos.dart';
import 'package:desafio/screen/perfil.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
//       home: MenuAtletaApp(),
//     );
//   }
// }

final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;

class MenuAtletaApp extends StatefulWidget {
  const MenuAtletaApp({super.key});

  @override
  State<MenuAtletaApp> createState() => _MenuAtletaAppState();
}

class _MenuAtletaAppState extends State<MenuAtletaApp> {
  int paginaAtual = 0;
  late PageController pc;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // _auth.signOut();
    verificaCadastroAtleta();
    pc = PageController(initialPage: paginaAtual);
  }

  Future<void> verificaCadastroAtleta() async {
    if (await VerificaCadastro() == false && await VerificaAnalise() == false) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => CadastroAtleta()),
        (route) => false,
      );
    }
    String status = await VerificaStatus();
    if (status == "Analise") {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Espera()),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) =>
                EditarAtleta(email: _auth.currentUser!.email)),
        (route) => false,
      );
    }
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: [
          TreinosApp(
            titulo: "Meus Treinos",
          ),
          DesempenhoApp(),
          CadastroPreTreinoApp(),
          MeuPerfilApp()
        ],
      ),
      bottomNavigationBar: SizedBox(
          height: 70,
          child: SafeArea(
            child: NavigationBar(
              indicatorColor: Colors.blueAccent,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.pool),
                  label: 'Meus Treinos',
                ),
                NavigationDestination(
                  icon: Icon(Icons.article),
                  label: 'Desempenho',
                ),
                NavigationDestination(
                  icon: Icon(Icons.punch_clock_outlined),
                  label: 'Realizar treino',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Perfil',
                ),
              ],
              selectedIndex: paginaAtual,
              onDestinationSelected: (int index) {
                setState(() {
                  paginaAtual = index;
                  pc.animateToPage(index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease);
                });
              },
            ),
          )),
    );
  }
}

Future<bool> VerificaCadastro() async {
  var documentSnapshot =
      await db.collection('Cadastro').doc(_auth.currentUser!.uid).get();

  return documentSnapshot.exists;
}

Future<bool> VerificaAnalise() async {
  var documentSnapshot =
      await db.collection('VerificaCadastro').doc(_auth.currentUser!.uid).get();

  return documentSnapshot.exists;
}

Future<String> VerificaStatus() async {
  var documentSnapshot =
      await db.collection('VerificaCadastro').doc(_auth.currentUser!.uid).get();

  var user = documentSnapshot.data()!["Status"];

  return user;
}
