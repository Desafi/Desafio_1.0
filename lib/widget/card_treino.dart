import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/treino_expandido.dart';
import 'package:desafio/widget/card_treinos.dart';
import 'package:flutter/material.dart';

class CardTreino_ extends StatelessWidget {
  final Function()? onTap;
  final Map<String, dynamic> user;
  final QueryDocumentSnapshot<Map<String, dynamic>> snap;

  const CardTreino_({
    super.key,
    required this.user,
    required this.snap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool? existe;
    FirebaseFirestore db = FirebaseFirestore.instance;

    return GestureDetector(
        onTap: onTap,
        child: CardTreinos(
          nome: user['NomeAtleta'],
          data: user['DataTreino'],
          estilo: user['TipoNado'],
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => TreinoExpandidoApp(
                        id: snap.id,
                      )),
            );
          },
        ));
  }
}
