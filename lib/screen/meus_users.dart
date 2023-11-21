import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/cadastro.dart';
import 'package:desafio/screen/tela_expandida_atleta.dart';
import 'package:desafio/screen/tela_nao_encontrada.dart';
import 'package:desafio/widget/card_pessoas.dart';
import 'package:desafio/widget/card_users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MeusUsers extends StatefulWidget {
  final String titulo;
  final String hintInput;
  final bool visivel;

  const MeusUsers({
    super.key,
    required this.titulo,
    required this.hintInput,
    required this.visivel,
  });

  @override
  State<MeusUsers> createState() => _MeusUsersState();
}

FirebaseFirestore db = FirebaseFirestore.instance;
final usersQuery = FirebaseFirestore.instance.collection('Usuarios');
bool? existe;
String? pesquisa;

class _MeusUsersState extends State<MeusUsers> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: widget.visivel,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const CadastroApp(
                        menuItems: [
                          DropdownMenuItem(
                              value: "Atleta", child: Text("Atleta")),
                        ],
                      )),
            );
          },
          isExtended: true,
          child: const Icon(Icons.add),
        ),
      ),
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

                Center(
                  child: Text(
                    widget.titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SearchBar(
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 25.0)),
                  hintText: widget.hintInput,
                  onChanged: (value) {
                    setState(() {
                      pesquisa = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                FirestoreListView<Map<String, dynamic>>(
                  physics: const BouncingScrollPhysics(),
                  pageSize: 3,
                  shrinkWrap: true,
                  loadingBuilder: (context) => LoadingAnimationWidget.inkDrop(
                      color: Colors.black, size: 2),
                  query: widget.titulo == 'Treinador'
                      ? usersQuery
                          .where('Tipo', isEqualTo: 'Treinador')
                          .orderBy('DataCriacao', descending: false)
                      : usersQuery
                          .where('Tipo', isEqualTo: 'Atleta')
                          .orderBy('DataCriacao', descending: false),
                  itemBuilder: (context, snapshot) {
                    if (pesquisa == null) {
                      Map<String, dynamic> user = snapshot.data();
                      return CardUsers(
                        user: user,
                      );
                    } else {
                      Map<String, dynamic> user = snapshot.data();
                      final nome = user['Nome'].toLowerCase().toString();

                      if (nome.contains(pesquisa!.toLowerCase())) {
                        return CardUsers(
                          user: user,
                        );
                      } else {
                        return Container();
                      }
                    }
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
