import 'package:desafio/widget/botao_principal.dart';
import 'package:desafio/widget/filter_chip.dart';
import 'package:flutter/material.dart';

void Modal(BuildContext context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                  height: 20,
                ),
                Text(
                  "Estilos",
                  style: TextStyle(fontSize: 20),
                ),
                BtnFiltro(
                  lista: ["crawl", "costas", "peito", "borboleta", "medley"],
                  onFilterSelected: (filtros) {
                    print(filtros);
                  },
                ),
                const SizedBox(
                  height: 20,
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
                  height: 20,
                ),
                Text(
                  "Tempo",
                  style: TextStyle(fontSize: 20),
                ),
                BtnFiltro(
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
                BotaoPrincipal(hintText: "Filtrar", cor: Colors.blue),
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
}
