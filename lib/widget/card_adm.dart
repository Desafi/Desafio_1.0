import 'package:flutter/material.dart';

class CardAdm extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final Function()? onTap;

  CardAdm({
    super.key,
    required this.titulo,
    required this.icone,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                icone,
                size: 40,
                color: Colors.green,
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                titulo,
                style: TextStyle(fontSize: 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}
