import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/tela_expandida_atleta.dart';
import 'package:desafio/screen/tela_nao_encontrada.dart';
import 'package:desafio/widget/card_pessoas.dart';
import 'package:flutter/material.dart';

class CardUsers extends StatelessWidget {
  final Function()? onTap;
  final Map<String, dynamic> user;

  const CardUsers({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool? existe;
    FirebaseFirestore db = FirebaseFirestore.instance;

    return GestureDetector(
      onTap: onTap,
      child: CardPessoas(
          url: user['ImagemAtleta'],
          email: user['Email'],
          nome: user['Nome'],
          onTap: () async {
            if (user['Tipo'] == 'Atleta') {
              QuerySnapshot querySnapshot = await db
                  .collection('Cadastro')
                  .where('Email', isEqualTo: user['Email'])
                  .get();

              existe = querySnapshot.docs.isNotEmpty;

              if (existe == true) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaExpandidaAtletaApp(
                          tabela: "Cadastro",
                              emailUser: user['Email'],
                            )));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NaoEncontrado()));
              }
            }
          }),
    );
  }
}
