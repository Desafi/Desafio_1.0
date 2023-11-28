import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/main.dart';
import 'package:desafio/screen/editar_atleta.dart';
import 'package:desafio/screen/tela_expandida_atleta.dart';
import 'package:desafio/widget/awesome_dialog.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:desafio/widget/botao_ui.dart';
import 'package:desafio/widget/scaffolds.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// void main() async {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MeuPerfilApp(),
//     );
//   }
// }

final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;

class MeuPerfilApp extends StatefulWidget {
  const MeuPerfilApp({super.key});

  @override
  State<StatefulWidget> createState() => _MeuPerfilAppState();
}

Map<String, dynamic>? user;
bool carregando = true;

class _MeuPerfilAppState extends State<MeuPerfilApp> {
  @override
  void initState() {
    _carregarInfoUser();

    super.initState();
  }

  Future<void> _carregarInfoUser() async {
    await db
        .collection("Usuarios")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((snapshot) {
      setState(() {
        user = snapshot.data();
        carregando = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(backgroundColor: Colors.blue, elevation: 0, actions: []),
      body: carregando == true
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.black, size: 200))
          : Column(
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.blue,
                      height: MediaQuery.of(context).size.height / 2.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              user!["Tipo"],
                              style: TextStyle(
                                fontSize: 35,
                                letterSpacing: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CircleAvatar(
                                radius: 90,
                                backgroundImage: user!["ImagemAtleta"] == null
                                    ? AssetImage('assets/images/person.jpg')
                                    : NetworkImage(
                                            user!["ImagemAtleta"].toString())
                                        as ImageProvider),
                            Text(user!["Nome"],
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24),
                                )),
                            Text(user!["Email"],
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BotaoUI(
                            onTap: () async {
                              try {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                        email: user!["Email"]);
                                MensagemAwesome(
                                    context,
                                    "Sucesso",
                                    "Foi enviado para seu e-mail um link para mudar sua senha!",
                                    false);
                              } catch (e) {
                                Mensagem(
                                    context,
                                    "Ocorreu um erro, tente mais tarde!",
                                    Colors.red);
                              }
                            },
                            hintText: "Editar senha",
                            icone: const Icon(
                              Icons.edit_outlined,
                              size: 25,
                            ),
                            cor: Colors.grey[400],
                          ),
                          BotaoUI(
                            onTap: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditarAtleta(
                                          email: user!["Email"],
                                        )),
                              );
                            },
                            hintText: "Editar Informações da conta",
                            icone: const Icon(
                              Ionicons.cog_outline,
                              size: 30,
                            ),
                            cor: Colors.grey[400],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: BotaoPrincipal(
                              radius: 30,
                              hintText: "Sair",
                              cor: Colors.red[500],
                              onTap: () async {
                                await _auth.signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const LoginApp()),
                                    (route) => false);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
