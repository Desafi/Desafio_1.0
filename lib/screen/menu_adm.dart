import 'package:desafio/main.dart';
import 'package:desafio/screen/cadastro.dart';
import 'package:desafio/screen/menu_gerencia.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:desafio/widget/card_adm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AdmApp(),
//     );
//   }
// }

class AdmApp extends StatefulWidget {
  const AdmApp({super.key});

  @override
  _AdmAppState createState() => _AdmAppState();
}

class _AdmAppState extends State<AdmApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 9,
                          blurRadius: 8,
                          offset: const Offset(0, 8),
                        )
                      ]),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.white,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/person.jpg'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Olá, João Antonio',
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          'joao@gmail.com',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Selecione',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 30),
                CardAdm(
                  titulo: 'Crie um usuário',
                  icone: Icons.add,
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const CadastroApp(
                                menuItems: [
                                  DropdownMenuItem(
                                      value: "Treinador",
                                      child: Text("Treinador")),
                                  DropdownMenuItem(
                                      value: "Atleta", child: Text("Atleta")),
                                ],
                              )),
                    );
                  },
                ),
                const SizedBox(height: 40),
                CardAdm(
                  titulo: 'Gerenciar usuários',
                  icone: Icons.manage_accounts,
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const MenuGerencia()),
                    );
                  },
                ),
                const SizedBox(height: 80),
                BotaoPrincipal(
                  hintText: 'Sair',
                  cor: Colors.red[400],
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginApp()),
                        (route) => false);
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
