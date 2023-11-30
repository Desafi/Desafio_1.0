import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/main.dart';
import 'package:desafio/screen/cadastro_atleta.dart';
import 'package:desafio/screen/perfil.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:desafio/widget/scaffolds.dart';
import 'package:desafio/widget/text_form_field_cadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Espera(),
//     );
//   }
// }

class EditaTreinadorApp extends StatefulWidget {
  String email;
  EditaTreinadorApp({required this.email, super.key});

  @override
  State<EditaTreinadorApp> createState() => _EditaTreinadorAppState();
}

FirebaseFirestore db = FirebaseFirestore.instance;

TextEditingController emailController = TextEditingController();
TextEditingController nomeController = TextEditingController();
String? _docId;
final _formKey = GlobalKey<FormState>();
bool _carregando = true;

final FirebaseAuth _auth = FirebaseAuth.instance;

class _EditaTreinadorAppState extends State<EditaTreinadorApp> {
  @override
  void initState() {
    _pegarInformacoes();
    super.initState();
  }

  Future<void> _pegarInformacoes() async {
    await db
        .collection("Usuarios")
        .where("Email", isEqualTo: widget.email)
        .get()
        .then((snapshot) {
      final firstDocument = snapshot.docs[0];
      setState(() {
        user = firstDocument.data();
        _docId = firstDocument.id;
        nomeController.text = user!["Nome"];
        _carregando = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                Navigator.pop(context);
              }),
        ),
        body: _carregando == true
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.black, size: 200))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Edite!',
                          style: GoogleFonts.plusJakartaSans(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 36),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Modifique e edite seu perfil.',
                          style: GoogleFonts.plusJakartaSans(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        // TextFormFieldCadastro(
                        //   formController: emailController,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return "Este campo é obrigatório!";
                        //     }
                        //     return null;
                        //   },
                        //   labelText: 'Email',
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormFieldCadastro(
                          formController: nomeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Este campo é obrigatório!";
                            }

                            return null;
                          },
                          labelText: 'Nome',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BotaoPrincipal(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                updateTreinador(
                                    emailController.text, nomeController.text);
                                Navigator.pop(context);
                                Mensagem(
                                    context, "Sucesso ao editar", Colors.green);
                              }
                            },
                            hintText: "Editar",
                            radius: 12,
                            cor: Colors.blueAccent)
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

Future<void> updateTreinador(String email, String nome) async {
  User? user = _auth.currentUser;
  final cadastroAtleta = <String, String>{
    // "Email": email,
    "Nome": nome,
  };

  try {
    // await user!.updateEmail(email);
    await db
        .collection("Usuarios")
        .doc(_docId)
        .update(cadastroAtleta)
        .onError((e, _) => print("Error writing document: $e"));
  } catch (e) {
    print('Erro$e');
  }
}
