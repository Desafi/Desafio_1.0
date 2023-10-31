import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/esqueciSenha.dart';
import 'package:desafio/model/login.dart';
import 'package:desafio/screen/menuAdm.dart';
import 'package:desafio/screen/menuAtleta.dart';
import 'package:desafio/screen/menuTreinador.dart';
import 'package:desafio/screen/splashScreen.dart';
import 'package:desafio/widget/BotaoLoader.dart';
import 'package:desafio/widget/Scaffolds.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyAppSplash());
}

String mensagem = '';
final FirebaseAuth _auth = FirebaseAuth.instance;
Login login = Login("", "", "");
FirebaseFirestore db = FirebaseFirestore.instance;
bool estaCarregando = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginApp(),
    );
  }
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<StatefulWidget> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        VerificaTipo(user.uid, context);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 75,
                      ),
                      Image.asset('assets/images/logoUnaerp.png', width: 200),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Bem Vindo!',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 36),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Faça o login e entre na plataforma.',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),

                      const SizedBox(
                        height: 50,
                      ),
                      //Email

                      TextFormField(
                        key: const Key('emailKey'),
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Este campo é obrigatório!";
                          }
                          login.email = value;
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
                          labelText: 'E-mail',
                        ),
                      ),
                      //Senha
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        key: const Key('senhaKey'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Este campo é obrigatório!";
                          }
                          if (value.length < 6) {
                            return "Senha precisa ter mais de 6 dígitos!";
                          }
                          login.senha = value;
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
                          labelText: 'Senha',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EsqueciSenhaApp()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Esqueceu sua senha?',
                                style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      BotaoLoader(
                        hintText: estaCarregando
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Entrar",
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
                                  await Logar(context);

                                  setState(() {
                                    estaCarregando = false;
                                  });
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

VerificaTipo(String userId, BuildContext context) {
  final docRef = db.collection("Usuarios").doc(userId);
  docRef.get().then((DocumentSnapshot documentSnapshot) {
    final Map<String, dynamic> data =
        documentSnapshot.data() as Map<String, dynamic>;
    final String tipo = data["Tipo"];
    switch (tipo) {
      case 'Administrador':
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AdmApp()),
            (route) => false);
        break;
      case 'Treinador':
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MenuTreinadorApp()),
            (route) => false);

        break;
      case 'Atleta':
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MenuAtletaApp()),
            (route) => false);
        break;
    }
  });
}

Logar(BuildContext context) async {
  try {
    UserCredential user = await _auth.signInWithEmailAndPassword(
        email: login.email, password: login.senha);

    VerificaTipo(user.user!.uid, context);
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'wrong-password':
        Mensagem(context, 'Senha incorreta. Tente novamente!', Colors.red);
        break;
      case 'invalid-email':
        Mensagem(context, 'E-mail inválido', Colors.red);
        break;
      case 'user-not-found':
        Mensagem(context, 'Usuário não encontrado.', Colors.red);
        break;
      case 'INVALID_LOGIN_CREDENTIALS':
        Mensagem(context, 'Dados incorretos.', Colors.red);
        break;
      default:
        Mensagem(context, 'Erro, tente novamente mais tarde!', Colors.red);
    }
  }
}
