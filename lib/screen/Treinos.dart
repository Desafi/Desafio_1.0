import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/cadastro_atleta.dart';
import 'package:desafio/screen/treino_expandido.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:desafio/widget/card_resultado.dart';
import 'package:desafio/widget/card_treinos.dart';
import 'package:desafio/widget/filter_chip.dart';
import 'package:desafio/widget/filter_chip_dois.dart';
import 'package:desafio/widget/modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
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
//       home: MeusTreinosApp(),
//     );
//   }
// }

class TreinosApp extends StatefulWidget {
  final String titulo;

  const TreinosApp({
    super.key,
    required this.titulo,
  });

  @override
  State<TreinosApp> createState() => _TreinosAppState();
}

enum ExerciseFilter { crawl, costas, peito, borboleta, medley }

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
List<String>? tipo;
List<String>? sexo;
String? tempo;

final atletaQuery = FirebaseFirestore.instance
    .collection('Treinos')
    .doc(_auth.currentUser!.uid)
    .collection("TreinoAtleta");

final treinadorQuery =
    FirebaseFirestore.instance.collectionGroup("TreinoAtleta");

class _TreinosAppState extends State<TreinosApp> {
  Set<ExerciseFilter> filters = <ExerciseFilter>{};
  var _mm = true;
  String? foto;
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
                Center(
                  child: Text(
                    widget.titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SearchBar(
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 15.0)),
                        hintText: "Digite o nome do atleta",
                        onChanged: (value) {
                          // setState(() {
                          //   pesquisa = value;
                          // });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            context: context,
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Selecione o filtro",
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Estilos",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        BtnFiltro(
                                          lista: [
                                            "crawl",
                                            "costas",
                                            "peito",
                                            "borboleta",
                                            "medley"
                                          ],
                                          onFilterSelected: (filtros) {
                                            print(filtros);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Sexo",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        BtnFiltro(
                                          lista: [
                                            "masculino",
                                            "feminino",
                                            "outro",
                                          ],
                                          onFilterSelected: (filtros) {
                                            print(filtros);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Tempo",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        BtnFiltroDois(
                                          lista: [
                                            "mais recentes",
                                            "mais antigos",
                                          ],
                                          onFilterSelected: (filtros) {
                                            print(filtros);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        BotaoPrincipal(
                                          hintText: "Filtrar",
                                          cor: Colors.blue,
                                          onTap: () {
                                          },
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.filter_list_outlined,
                          size: 34,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                FirestoreListView<Map<String, dynamic>>(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  query: widget.titulo == "Meus Treinos"
                      ? atletaQuery
                      : treinadorQuery,
                  itemBuilder: (context, snapshot) {
                    Map<String, dynamic> user = snapshot.data();
                    return CardTreinos(
                      nome: user['NomeAtleta'],
                      data: user['DataTreino'],
                      estilo: user['TipoNado'],
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => TreinoExpandidoApp(
                                    id: snapshot.id,
                                  )),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
