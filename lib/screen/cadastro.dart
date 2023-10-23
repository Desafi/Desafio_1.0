import 'dart:math';
import 'package:desafio/model/cadastro.dart';
import 'package:desafio/widget/AwesomeDialog.dart';
import 'package:desafio/widget/BotaoPrincipal.dart';
import 'package:desafio/widget/Scaffolds.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: CadastroApp(menuItems: []),
//   ));
// }

String? selectValue;
final FirebaseAuth _auth = FirebaseAuth.instance;

class CadastroApp extends StatefulWidget {
  final List<DropdownMenuItem<String>> menuItems;
  const CadastroApp({
    super.key,
    required this.menuItems,
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
                    TextFormField(
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        cadastro.nome = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Nome Completo',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'E-mail',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
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
                    BotaoPrincipal(
                      hintText: "Cadastrar",
                      cor: Colors.blueAccent,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          cadastro.senha = _GerarSenha();
                          Registrar(cadastro.email, cadastro.senha, context);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BotaoPrincipal(
                      hintText: "Cancelar",
                      cor: Colors.amber,
                      onTap: () {
                        Navigator.pop(context);
                      },
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

void Registrar(String email, String senha, BuildContext context) async {
  try {
    await _auth.createUserWithEmailAndPassword(email: email, password: senha);
    MensagemAwesome(context, "Sucesso",
        "Sucesso ao cadastrar, verifique o e-mail para mais informações!!");
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

_GerarSenha() {
  final random = Random();
  final min = 10000000;
  final max = 99999999;

  final numeroRandomico = min + random.nextInt(max - min + 1);
  return numeroRandomico.toString();
}
