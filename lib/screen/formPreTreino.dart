import 'package:desafio/screen/cronometro.dart';
import 'package:desafio/widget/BotaoPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:desafio/model/preTreino.dart';

void main() {
  runApp(const MyApp());
}

String? selectValue;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CadastroPreTreinoApp(),
    );
  }
}

class CadastroPreTreinoApp extends StatefulWidget {
  const CadastroPreTreinoApp({super.key});

  @override
  State<CadastroPreTreinoApp> createState() => _CadastroPreTreinoAppState();
}

class _CadastroPreTreinoAppState extends State<CadastroPreTreinoApp> {
  CadastroPreTreino cadastro = CadastroPreTreino("", "", "", "");

  final List<String> _kOptions = <String>[
    'joão',
    'lamarca',
    'caio',
  ];

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Crawl", child: Text("Crawl")),
      const DropdownMenuItem(value: "Costas", child: Text("Costas")),
    ];

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
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
                    'Cadastre pré-treino',
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Digite o nome do atleta",
                          textAlign: TextAlign.start),
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          return _kOptions.where((String option) {
                            final inputText =
                                textEditingValue.text.toLowerCase();
                            final optionText = option.toLowerCase();
                            return optionText.contains(inputText);
                          });
                        },
                        onSelected: (String selection) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
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
                      labelText: 'Frequencia cardíaca',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Este campo é obrigatório!";
                      }
                      cadastro.frequenciaCardiaca = value;
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
                      cadastro.estiloTreino = value;
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
                    hintText: "Iniciar",
                    cor: Colors.blueAccent,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CronometroApp()),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
