import 'package:desafio/main.dart';
import 'package:desafio/screen/cadastro.dart';
import 'package:desafio/screen/menu_gerencia.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:desafio/widget/card_adm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  _AdmAppState createState() => _AdmAppState();
}

class _AdmAppState extends State<AdmApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.grey[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
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
                SizedBox(height: 10),
                Text(
                  'Selecione',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 30),
                CardAdm(
                  titulo: 'Crie um usuário',
                  icone: Icons.add,
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => CadastroApp(
                                isVisible: true,
                                menuItems: [
                                  const DropdownMenuItem(
                                      value: "Treinador",
                                      child: Text("Treinador")),
                                  const DropdownMenuItem(
                                      value: "Atleta", child: Text("Atleta")),
                                ],
                              )),
                    );
                  },
                ),
                SizedBox(height: 40),
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
                SizedBox(height: 70),
                BotaoPrincipal(
                  hintText: 'Sair',
                  cor: Colors.red[400],
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginApp()),
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
