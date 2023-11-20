import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/cadastro_atleta.dart';
import 'package:desafio/screen/treino_expandido.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:desafio/widget/card_resultado.dart';
import 'package:desafio/widget/card_treinos.dart';
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

final atletaQuery = FirebaseFirestore.instance
    .collection('Treinos')
    .doc(_auth.currentUser!.uid)
    .collection("TreinoAtleta");

final treinadorQuery =
    FirebaseFirestore.instance.collectionGroup("TreinoAtleta");

class _TreinosAppState extends State<TreinosApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  var _mm = true;

  @override
  Widget build(BuildContext context) {
    List<String> filter = ["crawl", "costas", "peito", "borboleta", "hedley"];
    List<String> _filters = [];

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
                    ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text("Selecione o filtro"),
                                    Text("Tipo de nado"),
                                    Wrap(
                                      children: filter.map((filterType) {
                                        return FilterChip(
                                          label: Text(filterType),
                                          selected:
                                              _filters.contains(filterType),
                                          onSelected: (val) {
                                            setState(() {
                                              if (_filters
                                                  .contains(filterType)) {
                                                _filters.remove(
                                                    filterType); // Deselect the filter
                                              } else {
                                                _filters.add(
                                                    filterType); // Select the filter
                                              }
                                              print(_filters);
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    BotaoPrincipal(
                                        hintText: "Comparar atletas",
                                        cor: Colors.yellow),
                                    BotaoPrincipal(
                                        hintText: "Filtrar", cor: Colors.blue),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        // setState(() {
                        //   _mm = !_mm;
                        // });
                      },
                      child: IconButton(
                        icon: const Icon(Icons.filter_list_outlined),
                        onPressed: () {},
                        // icon: _mm
                        //     ? const Icon(Icons.filter_list_outlined)
                        //     : const Icon(Icons.arrow_drop_down),
                        // onPressed: () {
                        //   setState(() {
                        //     _mm = !_mm;
                        //   });
                        // },
                      ),
                    )
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
