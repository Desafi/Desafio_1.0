import 'package:desafio/screen/esqueciSenha.dart';
import 'package:desafio/screen/menuAdm.dart';
import 'package:desafio/screen/menuAtleta.dart';
import 'package:desafio/model/login.dart';
import 'package:desafio/screen/menuTreinador.dart';
import 'package:desafio/widget/BotaoPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

String mensagem = '';

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
  final _formKey = GlobalKey<FormState>();
  Login login = Login("", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: 350,
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
                                builder: (context) => const EsqueciSenhaApp()),
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
                    BotaoPrincipal(
                      key: const Key("botaoCotrole"),
                      cor: Colors.blueAccent,
                      hintText: "Entrar",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (login.email == "adm.com" &&
                              login.senha == "123") {
                            setState(() {
                              mensagem = 'Bem-vindo, Administrador!';
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const AdmApp()),
                            );
                          }

                          if (login.email == "atl.com" &&
                              login.senha == "123") {
                            setState(() {
                              mensagem = 'Bem-vindo, Atleta!';
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const MenuAtletaApp()),
                            );
                          }

                          if (login.email == "trei.com" &&
                              login.senha == "123") {
                            setState(() {
                              mensagem = 'Bem-vindo, Treinador!';
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const MenuTreinadorApp()),
                            );
                          }
                        }
                      },
                    )
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
