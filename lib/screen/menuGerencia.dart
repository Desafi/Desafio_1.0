import 'package:desafio/screen/meusUsers.dart';
import 'package:desafio/widget/CardPessoas.dart';
import 'package:desafio/widget/Skeleton.dart';
import 'package:firebase_core/firebase_core.dart';
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
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
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
        body: const TabBarView(
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
