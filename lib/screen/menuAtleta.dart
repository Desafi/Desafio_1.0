import 'package:desafio/screen/cadastro.dart';
import 'package:desafio/screen/cronometro.dart';
import 'package:desafio/screen/esqueciSenha.dart';
import 'package:desafio/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        children: [
          CronometroApp(),
          LoginApp(),
          EsqueciSenhaApp(),
          CadastroApp()
        ],
        onPageChanged: setPaginaAtual,
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
                      duration: Duration(milliseconds: 400),
                      curve: Curves.ease);
                });
              },
            ),
          )),
    );
  }
}
