import 'package:flutter/material.dart';

class CardTreinos extends StatelessWidget {
  final String? nome;
  final String estilo;
  final String data;
  final Function()? onTap;


  const CardTreinos({
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/person.jpg'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                      visible: nome != null,
                      child: Text('Nome: $nome', style: const TextStyle(fontSize: 16))),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Estilo de treino: $estilo',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Data do treino: $data', style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
