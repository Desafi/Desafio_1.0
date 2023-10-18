import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:desafio/widget/BotaoPrincipal.dart';
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
      theme: ThemeData(),
      home: const EsqueciSenhaApp(),
    );
  }
}

class EsqueciSenhaApp extends StatefulWidget {
  const EsqueciSenhaApp({super.key});

  @override
  State<EsqueciSenhaApp> createState() => _EsqueciSenhaAppState();
}

class _EsqueciSenhaAppState extends State<EsqueciSenhaApp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                      'Esqueceu sua senha?',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Digite seu e-mail e recupere!',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
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
                        return null;
                      },
                    ),

                    //Senha
                    const SizedBox(
                      height: 10,
                    ),

                    Column(
                      children: [
                        BotaoPrincipal(
                          cor: Colors.blueAccent,
                          hintText: "Enviar",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.bottomSlide,
                                showCloseIcon: true,
                                title: "Sucesso",
                                desc:
                                    "Sucesso ao recuperar senha, verifique o e-mail para mais informações!!",
                                btnOkOnPress: () {},
                              ).show();

                              // mostrarSucesso(
                              //     context, "Sucesso ao cadastrar!", Colors.green);
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
