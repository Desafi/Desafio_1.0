import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/widget/CardPessoas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MeusUsers extends StatefulWidget {
  final String titulo;
  final String hintInput;

  const MeusUsers({
    super.key,
    required this.titulo,
    required this.hintInput,
  });

  @override
  State<MeusUsers> createState() => _MeusUsersState();
}

FirebaseFirestore db = FirebaseFirestore.instance;
final usersQuery = FirebaseFirestore.instance.collection('Usuarios');

class _MeusUsersState extends State<MeusUsers> {
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
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SearchAnchor(builder:
                    (BuildContext context, SearchController controller) {
                  return SearchBar(
                    hintText: (widget.hintInput),
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
                }, suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  List<String> items = [
                    'João',
                    'Caio',
                    'Gabriel',
                    'Luiz',
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
                const SizedBox(
                  height: 30,
                ),
                FirestoreListView<Map<String, dynamic>>(
                  shrinkWrap: true,
                  loadingBuilder: (context) => LoadingAnimationWidget.inkDrop(color: Colors.black, size: 2),
                  query: widget.titulo == 'Treinador'
                      ? usersQuery.where('Tipo', isEqualTo: 'Treinador')
                      : usersQuery.where('Tipo', isEqualTo: 'Atleta'),
                  itemBuilder: (context, snapshot) {
                    Map<String, dynamic> user = snapshot.data();
                    return CardPessoas(
                      email: user['Email'],
                      nome: user['Nome'],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
