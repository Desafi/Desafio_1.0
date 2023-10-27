import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/helper/Define.dart';
import 'package:desafio/model/cadastro.dart';
import 'package:desafio/widget/AwesomeDialog.dart';
import 'package:desafio/widget/BotaoLoader.dart';
import 'package:desafio/widget/BotaoPrincipal.dart';
import 'package:desafio/widget/Scaffolds.dart';
import 'package:desafio/widget/TextFormFieldCadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: CadastroApp(menuItems: []),
//   ));
// }

String? selectValue;
final FirebaseAuth _auth = FirebaseAuth.instance;
bool estaCarregando = false;
FirebaseFirestore db = FirebaseFirestore.instance;

class CadastroApp extends StatefulWidget {
  final List<DropdownMenuItem<String>> menuItems;
  final bool isVisible;

  const CadastroApp({
    super.key,
    required this.menuItems,
    required this.isVisible,
  });

  @override
  State<CadastroApp> createState() => _CadastroAppState();
}

class _CadastroAppState extends State<CadastroApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
 
  }

  Cadastro cadastro = Cadastro("", "", "", "");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Image.asset('assets/images/logoUnaerp.png', width: 200),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      textAlign: TextAlign.start,
                      'Cadastre um usuário',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 26),
                      ),
                    ),
                    Text(
                      'Preencha as informações:',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormFieldCadastro(
                      labelText: "Nome Completo",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        cadastro.nome = value;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormFieldCadastro(
                      labelText: "E-mail",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        cadastro.email = value;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                      value: null,
                      items: widget.menuItems,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        cadastro.tipo = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: (String? value) {
                        selectValue = value;
                      },
                      hint: const Text('Selecione uma opção'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BotaoLoader(
                      hintText: estaCarregando
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Cadastrar",
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                      cor: Colors.blueAccent,
                      onTap: estaCarregando
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  estaCarregando = true;
                                });

                                cadastro.senha = _GerarSenha();
                                await Registrar(cadastro.email, cadastro.senha,
                                    cadastro.tipo, cadastro.nome, context);

                                setState(() {
                                  estaCarregando = false;
                                });
                              }
                            },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: widget.isVisible,
                      child: BotaoPrincipal(
                        hintText: "Cancelar",
                        cor: Colors.amber,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Registrar(String email, String senha, String tipo, String nome,
    BuildContext context) async {
  try {
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: senha);
    final String userId = userCredential.user!.uid;
    //Cadastra os dados no banco
    await _CadastraBanco(userId, nome, email, tipo, context);

    //Envia a senha para o email cadastrado
    await _EnviarEmail(email, senha, context);
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'email-already-in-use':
        Mensagem(context, 'Este e-mail já está cadastrado!', Colors.red);
        break;
      case 'invalid-email':
        Mensagem(context, 'E-mail inválido', Colors.red);
        break;
      default:
        Mensagem(context, 'Erro, tente novamente mais tarde!', Colors.red);
    }
  }
}

_CadastraBanco(String userId, String nome, String email, String tipo,
    BuildContext context) {
  try {
    final user = <String, dynamic>{
      "Nome": nome,
      "Email": email,
      "Tipo": tipo,
    };

    db.collection("Usuarios").doc(userId).set(user);
  } catch (e) {
    Mensagem(context,
        "Ocorreu um erro ao cadastrar, tente novamente mais tarde", Colors.red);
  }
}

_EnviarEmail(String email, String senha, BuildContext context) async {
  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'Unaqua')
    ..recipients.add(email)
    ..subject = 'Senha da Unaqua'
    ..text =
        'Sua senha para entrar no aplicativo é: $senha, troque ela assim que possivel!';
  try {
    final sendReport = await send(message, smtpServer);
    MensagemAwesome(context, "Sucesso",
        "Sucesso ao cadastrar, verifique o e-mail para mais informações!!");
  } on MailerException catch (e) {
    Mensagem(context, "Erro ao enviar e-mail, contate o suporte", Colors.red);
  }
}

_GerarSenha() {
  final random = Random();
  const min = 10000000;
  const max = 99999999;

  final numeroRandomico = min + random.nextInt(max - min + 1);
  return numeroRandomico.toString();
}
