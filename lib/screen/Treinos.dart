import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/comparar_atletas.dart';
import 'package:desafio/widget/card_treino.dart';
import 'package:desafio/widget/filter_chip.dart';
import 'package:desafio/widget/filter_chip_dois.dart';
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
  final bool searchBar;

  const TreinosApp({
    super.key,
    required this.searchBar,
    required this.titulo,
  });

  @override
  State<TreinosApp> createState() => _TreinosAppState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;

List<String> estilosSelecionados = [
  "Crawl",
  "Costas",
  "Peito",
  "Borboleta",
  "Medley"
];
List<String> sexoSelecionado = ["Masculino", "Feminino", "Outro"];
String tempoSelecionado = "Mais recentes";

String? tempo;
bool decrescente = true;
String? pesquisa;
// final atletaQuery = FirebaseFirestore.instance
//     .collection('Treinos')
//     .doc(_auth.currentUser!.uid)
//     .collection("TreinoAtleta");

// final treinadorQuery =
//     FirebaseFirestore.instance.collectionGroup("TreinoAtleta");

// var teste = FirebaseFirestore.instance
//     .collectionGroup("TreinoAtleta")
//     .where(Filter.and(Filter("SexoAtleta", whereIn: sexoSelecionado),
//         Filter("TipoNado", whereIn: estilosSelecionados)))
//     .orderBy("DataTreino", descending: false);

class _TreinosAppState extends State<TreinosApp> {
  String? foto;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: widget.titulo == "Treinos",
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CompararAtletaApp()),
            );
          },
          isExtended: true,
          child: const Icon(Icons.compare_arrows_sharp),
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
                Row(
                  children: [
                    Expanded(
                      child: Visibility(
                        // visible: widget.searchBar,
                        child: SearchBar(
                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 15.0)),
                          hintText: "Digite o nome do atleta",
                          onChanged: (value) {
                            setState(() {
                              pesquisa = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
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
                                        const Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Selecione o filtro",
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Estilos",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        BtnFiltro(
                                          selecionado: estilosSelecionados,
                                          lista: const [
                                            "Crawl",
                                            "Costas",
                                            "Peito",
                                            "Borboleta",
                                            "Medley"
                                          ],
                                          onFilterSelected: (filtros) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              setState(() {
                                                estilosSelecionados = filtros;
                                              });
                                            });
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Visibility(
                                            visible:
                                                widget.titulo != "Meus Treinos",
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "Sexo",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                BtnFiltro(
                                                  selecionado: sexoSelecionado,
                                                  lista: const [
                                                    "Masculino",
                                                    "Feminino",
                                                    "Outro",
                                                  ],
                                                  onFilterSelected: (filtros) {
                                                    WidgetsBinding.instance
                                                        .addPostFrameCallback(
                                                            (_) {
                                                      setState(() {
                                                        sexoSelecionado =
                                                            filtros;
                                                      });
                                                    });
                                                  },
                                                ),
                                              ],
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Tempo",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        BtnFiltroDois(
                                          tempoSelecionado: tempoSelecionado,
                                          lista: const [
                                            "Mais recentes",
                                            "Mais antigos",
                                          ],
                                          onFilterSelected: (filtros) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              setState(() {
                                                if (filtros ==
                                                    "Mais recentes") {
                                                  decrescente = true;
                                                  tempoSelecionado =
                                                      "Mais recentes";
                                                } else {
                                                  decrescente = false;
                                                  tempoSelecionado =
                                                      "Mais antigos";
                                                }
                                              });
                                            });
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
                        child: const Icon(
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
                      ? FirebaseFirestore.instance
                          .collection('Treinos')
                          .doc(_auth.currentUser!.uid)
                          .collection("TreinoAtleta")
                          .where("TipoNado", whereIn: estilosSelecionados)
                          .orderBy("DataTreino", descending: decrescente)
                      : FirebaseFirestore.instance
                          .collectionGroup("TreinoAtleta")
                          .where(Filter.and(
                              Filter("SexoAtleta", whereIn: sexoSelecionado),
                              Filter("TipoNado", whereIn: estilosSelecionados)))
                          .orderBy("DataTreino", descending: decrescente),
                  itemBuilder: (context, snapshot) {
                    if (pesquisa == null) {
                      Map<String, dynamic> user = snapshot.data();
                      return CardTreino_(
                        snap: snapshot,
                        user: user,
                      );
                    } else {
                      Map<String, dynamic> user = snapshot.data();
                      final nome = user['NomeAtleta'].toLowerCase().toString();

                      if (nome.contains(pesquisa!.toLowerCase().toString())) {
                        return CardTreino_(
                          snap: snapshot,
                          user: user,
                        );
                      } else {
                        return Container();
                      }
                    }
                  },
                  loadingBuilder: (context) => const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
