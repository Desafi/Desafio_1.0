import 'package:cloud_firestore/cloud_firestore.dart';
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

final atletaQuery = FirebaseFirestore.instance
    .collection('Treinos')
    .doc(_auth.currentUser!.uid)
    .collection("TreinoAtleta");

final treinadorQuery = FirebaseFirestore.instance.collection('Treinos').doc().collection("TreinoAtleta");

class _TreinosAppState extends State<TreinosApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  var _mm = true;

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
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SearchAnchor(builder: (BuildContext context,
                            SearchController controller) {
                          return SearchBar(
                            controller: controller,
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.symmetric(horizontal: 16.0)),
                            onTap: () {
                              controller.openView();
                            },
                            onChanged: (_) {
                              controller.openView();
                            },
                            leading: const Icon(Icons.search),
                            trailing: const <Widget>[],
                          );
                        }, suggestionsBuilder: (BuildContext context,
                            SearchController controller) {
                          List<String> items = [
                            'Crawl',
                          ];
                          return items.map((String item) {
                            return ListTile(
                              title: Text(item),
                              onTap: () {
                                setState(() {
                                  controller.closeView(item);
                                });
                              },
                            );
                          }).toList();
                        }),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _mm = !_mm;
                        });
                      },
                      child: IconButton(
                        icon: _mm
                            ? const Icon(Icons.arrow_drop_up)
                            : const Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          setState(() {
                            _mm = !_mm;
                          });
                        },
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
                  query: treinadorQuery,
                  // widget.titulo == "Meus Treinos"
                  //     ? atletaQuery
                  //     : treinadorQuery,
                  itemBuilder: (context, snapshot) {
                    Map<String, dynamic> user = snapshot.data();
                    print(user);
                    return CardTreinos(
                      nome: user['NomeAtleta'],
                      data: user['DataTreino'],
                      estilo: user['TipoNado'],
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
