import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/main.dart';
import 'package:desafio/screen/splash_screen.dart';
import 'package:desafio/widget/awesome_dialog.dart';
import 'package:desafio/widget/botao_loader.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:desafio/widget/scaffolds.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(),
//       home: const PrimeiroAcessoApp(),
//     );
//   }
// }
FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

TextEditingController email = TextEditingController();
TextEditingController senha = TextEditingController();
TextEditingController repetirSenha = TextEditingController();

Map<String, dynamic>? user;
bool _mostrarSenha = true;
bool _mostrarRepetirSenha = true;
bool estaCarregando = false;

class PrimeiroAcessoApp extends StatefulWidget {
  const PrimeiroAcessoApp({super.key});

  @override
  State<PrimeiroAcessoApp> createState() => _PrimeiroAcessoAppState();
}

class _PrimeiroAcessoAppState extends State<PrimeiroAcessoApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> VerificaUser(
      String email, String senha, BuildContext context) async {
    final querySnapshot = await db
        .collection("PreCadastro")
        .where("Email", isEqualTo: email)
        .get();

    if (querySnapshot.size > 0) {
      for (var docSnapshot in querySnapshot.docs) {
        setState(() {
          user = docSnapshot.data();
        });
      }

      registrar(email, senha, user!["Nome"], user!["Tipo"], context);
    } else {
      Mensagem(context, "E-mail inválido", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Image.asset('assets/images/logoUnaerp.png', width: 200),
                    const SizedBox(
                      height: 75,
                    ),
                    Text(
                      'Primeiro acesso',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Digite seu e-mail e senha para criar sua conta!',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: email,
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
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: senha,
                      obscureText: _mostrarSenha,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: _mostrarSenha == true
                              ? Icon(Icons.remove_red_eye)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _mostrarSenha = !_mostrarSenha;
                            });
                          },
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Senha',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: repetirSenha,
                      obscureText: _mostrarRepetirSenha,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: _mostrarRepetirSenha == true
                              ? Icon(Icons.remove_red_eye)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _mostrarRepetirSenha = !_mostrarRepetirSenha;
                            });
                          },
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Repetir senha',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        BotaoLoader(
                          hintText: estaCarregando
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
                                  "Enviar",
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
                                  if (_formKey.currentState!.validate() &&
                                      senha.text == repetirSenha.text) {
                                    setState(() {
                                      estaCarregando = true;
                                    });
                                    await VerificaUser(
                                        email.text, senha.text, context);
                                    setState(() {
                                      estaCarregando = false;
                                    });
                                  } else {
                                    Mensagem(context, "Senhas não são iguais!",
                                        Colors.red);
                                    setState(() {
                                      estaCarregando = false;
                                    });
                                  }
                                },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BotaoPrincipal(
                          cor: Colors.amber,
                          hintText: "Voltar",
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
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

registrar(String email, String senha, String nome, String tipo,
    BuildContext context) async {
  try {
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: senha);
    final String userId = userCredential.user!.uid;
    //Pega hora atual
    final dataAtual = Data();
    //Cadastra os dados no banco

    await _cadastraBanco(userId, nome, email, tipo, dataAtual, context);

    await _excluirTabela(email, context);
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

_cadastraBanco(String userId, String nome, String email, String tipo,
    String data, BuildContext context) {
  try {
    final user = <String, dynamic>{
      "Nome": nome,
      "Email": email,
      "Tipo": tipo,
      "DataCriacao": data
    };

    db.collection("Usuarios").doc(userId).set(user);
  } catch (e) {
    Mensagem(context,
        "Ocorreu um erro ao cadastrar, tente novamente mais tarde", Colors.red);
  }
}

_excluirTabela(String email, BuildContext context) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection("PreCadastro")
      .where("Email", isEqualTo: email)
      .get();

  for (var doc in querySnapshot.docs) {
    await doc.reference.delete();
  }
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SplashScreen()),
      (route) => false);
}

// _EnviarEmail(String email, String senha, BuildContext context) async {
//   final smtpServer = gmail(username, password);

//   final message = Message()
//     ..from = const Address(username, 'Unaqua')
//     ..recipients.add(email)
//     ..subject = 'Senha da Unaqua'
//     ..text =
//         'Sua senha para entrar no aplicativo é: $senha, troque ela assim que possivel!';
//   try {
//     await send(message, smtpServer);
//     MensagemAwesome(context, "Sucesso",
//         "Sucesso ao cadastrar, verifique o e-mail para mais informações!!");
//   } on MailerException {
//     Mensagem(context, "Erro ao enviar e-mail, contate o suporte", Colors.red);
//   }
// }

String Data() {
  DateTime agora = DateTime.now();
  String formato = DateFormat('dd-MM-yyyy - kk:mm:ss').format(agora);
  return formato.toString();
}
