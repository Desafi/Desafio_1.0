import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/cadastro_atleta.dart';
import 'package:desafio/screen/treino_expandido.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:desafio/widget/card_resultado.dart';
import 'package:desafio/widget/card_treinos.dart';
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

  const TreinosApp({
    super.key,
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

final atletaQuery = FirebaseFirestore.instance
    .collection('Treinos')
    .doc(_auth.currentUser!.uid)
    .collection("TreinoAtleta");

final treinadorQuery =
    FirebaseFirestore.instance.collectionGroup("TreinoAtleta");

var teste = FirebaseFirestore.instance
    .collectionGroup("TreinoAtleta")
    .where(Filter.and(Filter("SexoAtleta", whereIn: sexoSelecionado),
        Filter("TipoNado", whereIn: estilosSelecionados)))
    .orderBy("DataTreino", descending: false);

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
                                          selecionado: sexoSelecionado,
                                          lista: [
                                            "Masculino",
                                            "Feminino",
                                            "Outro",
                                          ],
                                          onFilterSelected: (filtros) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              setState(() {
                                                sexoSelecionado = filtros;
                                              });
                                            });
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
                                          tempoSelecionado: tempoSelecionado,
                                          lista: [
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
                  query: FirebaseFirestore.instance
                      .collectionGroup("TreinoAtleta")
                      .where(Filter.and(
                          Filter("SexoAtleta", whereIn: sexoSelecionado),
                          Filter("TipoNado", whereIn: estilosSelecionados)))
                      .orderBy("DataTreino", descending: decrescente),
                  // query: widget.titulo == "Meus Treinos"
                  //     ? atletaQuery
                  //     : treinadorQuery,
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
