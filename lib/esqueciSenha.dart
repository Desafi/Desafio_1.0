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
      home: EsqueciSenhaApp(),
    );
  }
}

class EsqueciSenhaApp extends StatefulWidget {
  const EsqueciSenhaApp({super.key});

  @override
  State<EsqueciSenhaApp> createState() => _EsqueciSenhaAppState();
}

class _EsqueciSenhaAppState extends State<EsqueciSenhaApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 75,
                ),
                Image.asset('assets/images/logoUnaerp.png', width: 200),
                SizedBox(
                  height: 75,
                ),
                Text(
                  'Esqueceu sua senha?',
                  style: GoogleFonts.plusJakartaSans(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 36),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Digite seu e-mail e recupere!',
                  style: GoogleFonts.plusJakartaSans(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                //Email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      fillColor: Colors.grey[100],
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                    ),
                  ),
                ),
                //Senha
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Enviar',
                            style: GoogleFonts.plusJakartaSans(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Voltar',
                            style: GoogleFonts.plusJakartaSans(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
