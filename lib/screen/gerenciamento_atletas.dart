import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/gerencia_atleta.dart';
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
      home: GerenciamentoAtletasApp(),
    );
  }
}

FirebaseFirestore db = FirebaseFirestore.instance;

class GerenciamentoAtletasApp extends StatefulWidget {
  const GerenciamentoAtletasApp({super.key});

  @override
  State<GerenciamentoAtletasApp> createState() =>
      _GerenciamentoAtletasAppState();
}

class _GerenciamentoAtletasAppState extends State<GerenciamentoAtletasApp> {
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
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor: const Color(0xFF42A5F5),
            title: const Text('Gerencie atletas'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Cadastro',
                ),
                Tab(
                  text: 'Enviado para análise',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              GerenciaAtleta(
                titulo: "Cadastro de atletas",
                subTitulo:
                    "Cadastre as informações dos novos atletas, clique e preencha!",
              ),
              GerenciaAtleta(
                titulo: "Verifique os atletas",
                subTitulo:
                    "Clique e verifique se as informações dos atletas estão corretas!",
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
