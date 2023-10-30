import 'package:desafio/main.dart';
import 'package:desafio/screen/menuGerencia.dart';
import 'package:desafio/screen/cadastro.dart';
import 'package:desafio/widget/CardAdm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdmApp(),
    );
  }
}

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red), // Defina a cor desejada
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginApp()),
                          (route) => false);
                    },
                    icon: Icon(Icons.exit_to_app),
                    label: Text("Sair"),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/logoUnaerp.png',
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                textAlign: TextAlign.start,
                'Bem vindo!!',
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 26),
                ),
              ),
              Text(
                'Escolha uma opção',
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CardAdm(
                imagem: "assets/images/Atleta.jpg",
                titulo: "Crie um usuário",
                subTitulo: "Clique e cadastre",
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
              const SizedBox(
                height: 20,
              ),
              CardAdm(
                imagem: "assets/images/gerenciar.png",
                titulo: "Gerencie os usuários",
                subTitulo: "Clique e veja",
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const MenuGerencia()),
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
