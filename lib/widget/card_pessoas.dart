import 'package:flutter/material.dart';

class CardPessoas extends StatelessWidget {
  final String nome;
  final String email;
  final String? url;
  final Function()? onTap;

  const CardPessoas({
    super.key,
    required this.nome,
    required this.email,
    this.url,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                    radius: 40,
                    backgroundImage: url == null
                        ? const AssetImage('assets/images/person.jpg')
                        : NetworkImage(url.toString()) as ImageProvider
                        ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(nome, style: const TextStyle(fontSize: 16)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(email, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
