import 'package:desafio/screen/meusUsers.dart';
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
    return MaterialApp(
      home: MenuGerencia(),
    );
  }
}

class MenuGerencia extends StatefulWidget {
  const MenuGerencia({super.key});

  @override
  State<MenuGerencia> createState() => _MenuGerenciaState();
}

class _MenuGerenciaState extends State<MenuGerencia> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gerencie usuarios'),
          bottom: TabBar(
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
            MeusUsers(cards: [
              CardPessoas(nome: 'João Antônio'),
              CardPessoas(nome: 'Caio'),
            ], titulo: 'Treinador', hintInput: 'Digite o nome do treinador..'),
            MeusUsers(cards: [
              CardPessoas(nome: 'João Antônio', telefone: '62262626262'),
              CardPessoas(nome: 'Caio', telefone: '1699595994'),
            ], titulo: 'Atletas', hintInput: 'Digite o nome do atleta..'),
          ],
        ),
      ),
    );
  }
}
