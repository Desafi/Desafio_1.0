import 'package:desafio/screen/cadastro.dart';
import 'package:desafio/screen/formPreTreino.dart';
import 'package:desafio/screen/meusTreinos.dart';
import 'package:desafio/screen/meusUsers.dart';
import 'package:desafio/screen/perfil.dart';
import 'package:desafio/widget/CardPessoas.dart';
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
      home: MenuTreinadorApp(),
    );
  }
}

class MenuTreinadorApp extends StatefulWidget {
  const MenuTreinadorApp({super.key});

  @override
  State<MenuTreinadorApp> createState() => _MenuTreinadorAppState();
}

class _MenuTreinadorAppState extends State<MenuTreinadorApp> {
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
        children: [
          CadastroApp(),
          MeusUsers(cards: [
            CardPessoas(nome: 'João Antônio', telefone: '62262626262'),
            CardPessoas(nome: 'Caio', telefone: '1699595994'),
          ], titulo: 'Atletas', hintInput: 'Digite o nome do atleta..'),
          CadastroPreTreinoApp(),
          MeusTreinosApp(),
          MeuPerfilApp(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: NavigationBar(
          indicatorColor: Colors.blueAccent,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.mode_edit_outline_outlined),
              label: 'Criar atleta',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_pin_outlined),
              label: 'Gerir atleta',
            ),
            NavigationDestination(
              icon: Icon(Icons.pool),
              label: 'Iniciar treino',
            ),
            NavigationDestination(
              icon: Icon(Icons.article_outlined),
              label: 'Gerir treinos',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Meu Perfil',
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
      ),
    );
  }
}
