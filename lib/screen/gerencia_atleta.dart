import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/cadastro_atleta.dart';
import 'package:desafio/screen/tela_expandida_atleta.dart';
import 'package:desafio/widget/card_users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GerenciaAtleta extends StatefulWidget {
  final String titulo;
  final String subTitulo;

  const GerenciaAtleta({
    super.key,
    required this.titulo,
    required this.subTitulo,
  });

  @override
  State<GerenciaAtleta> createState() => _GerenciaAtletaState();
}

FirebaseFirestore db = FirebaseFirestore.instance;

final analiseQuery = FirebaseFirestore.instance.collection('VerificaCadastro');
final cadastroQuery = FirebaseFirestore.instance.collection('Usuarios');

bool? existe;
String? pesquisa;

class _GerenciaAtletaState extends State<GerenciaAtleta> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Text(
                      widget.titulo,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.subTitulo,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),

                FirestoreListView<Map<String, dynamic>>(
                  physics: const BouncingScrollPhysics(),
                  pageSize: 3,
                  shrinkWrap: true,
                  loadingBuilder: (context) => LoadingAnimationWidget.inkDrop(
                      color: Colors.black, size: 2),
                  query: widget.titulo == 'Cadastro de atletas'
                      ? cadastroQuery.where('Status', isEqualTo: "PreCadastro")
                      : analiseQuery.where("Status", isEqualTo: "Analise"),
                  itemBuilder: (context, snapshot) {
                    Map<String, dynamic> user = snapshot.data();

                    return widget.titulo == 'Cadastro de atletas'
                        ? InkWell(
                            onTap: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CadastroAtleta(
                                    botaoVoltar:true,
                                    email: user["Email"],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: Container(
                                width: 400,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF7F2FA),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(user["Nome"],
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(user["Email"],
                                              style: const TextStyle(
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TelaExpandidaAtletaApp(
                                      tabela: "VerificaCadastro",
                                      emailUser: user["Email"].toString()),
                                ),
                              );
                            },
                            child: Card(
                              child: Container(
                                width: 400,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF7F2FA),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(user["NomeCompleto"],
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(user["Email"],
                                              style: const TextStyle(
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                ), //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
