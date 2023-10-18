import 'package:desafio/screen/desempenho.dart';
import 'package:desafio/screen/formPreTreino.dart';
import 'package:desafio/screen/Treinos.dart';
import 'package:desafio/screen/perfil.dart';
import 'package:desafio/widget/CardTreinos.dart';
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
      home: MenuAtletaApp(),
    );
  }
}

class MenuAtletaApp extends StatefulWidget {
  const MenuAtletaApp({super.key});

  @override
  State<MenuAtletaApp> createState() => _MenuAtletaAppState();
}

class _MenuAtletaAppState extends State<MenuAtletaApp> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();

    pc = PageController(initialPage: paginaAtual);
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
        children: const [
          TreinosApp(
            cards: [
              CardTreinos(
                estilo: "Borboleta",
                data: "11/05/2023",
              ),
              CardTreinos(
                estilo: "Crawl",
                data: "12/05/2023",
              ),
            ],
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
