import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardTreinos extends StatelessWidget {
  final String? nome;
  final String estilo;
  final String data;
  final Function()? onTap;

  CardTreinos({
    super.key,
    this.nome,
    required this.estilo,
    required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          width: 400,
          height: 100,
          decoration: BoxDecoration(
              color: const Color(0xFFF7F2FA),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  width: 100,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/waves.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nome.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w400)),
                        Text('Estilo: $estilo',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(data, style: const TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         children: [
          //           Text(nome.toString(),
          //               style: GoogleFonts.poppins(
          //                   fontSize: 18, fontWeight: FontWeight.w400)),
          //           const SizedBox(
          //             height: 10,
          //           ),
          //           Text('Estilo: $estilo',
          //               style: const TextStyle(fontSize: 16)),
          //           const SizedBox(
          //             height: 10,
          //           ),
          //           Text(data, style: const TextStyle(fontSize: 11)),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
