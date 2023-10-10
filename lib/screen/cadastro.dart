import 'package:desafio/model/cadastro.dart';
import 'package:desafio/widget/BotaoPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MaterialApp(
    home: CadastroApp(),
  ));
}

String? selectValue;
String? sds;

class CadastroApp extends StatefulWidget {
  const CadastroApp({super.key});

  @override
  State<CadastroApp> createState() => _CadastroAppState();
}

class _CadastroAppState extends State<CadastroApp> {
  Cadastro cadastro = Cadastro("", "", "");

  TextEditingController senhaController = TextEditingController();
  TextEditingController repetirSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Treinador", child: Text("Treinador")),
      const DropdownMenuItem(value: "Atleta", child: Text("Atleta")),
    ];

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: SizedBox(
              width: 350,
              child: Form(
                key: formKey,
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
                      items: menuItems,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        cadastro.tipo = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
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
                    const BotaoPrincipal(
                      hintText: "Cadastrar",
                      cor: Colors.amber,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const BotaoPrincipal(
                      hintText: "Cancelar",
                      cor: Colors.blueAccent,
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
