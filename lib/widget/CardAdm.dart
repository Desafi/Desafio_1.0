import 'package:flutter/material.dart';

class CardAdm extends StatelessWidget {
  final String titulo;
  final String subTitulo;
  final String imagem;
  final Function()? onTap;

  CardAdm({
    super.key,
    required this.titulo,
    required this.subTitulo,
    required this.imagem,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: const BoxDecoration(),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: Image.asset(
                  imagem.toString(),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFf7f1fb),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(titulo,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(
                        subTitulo,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
