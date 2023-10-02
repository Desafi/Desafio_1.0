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
      home: CadastroPreTreinoApp(),
    );
  }
}

class CadastroPreTreinoApp extends StatefulWidget {
  const CadastroPreTreinoApp({super.key});

  @override
  State<CadastroPreTreinoApp> createState() => _CadastroPreTreinoAppState();
}

class CadastroPreTreino {
  String? nome;
  String? frequenciaCardiaca;
  String? estiloTreino;
  String? dataTreino;

  CadastroPreTreino(
      this.nome, this.frequenciaCardiaca, this.estiloTreino, this.dataTreino);
}

class _CadastroPreTreinoAppState extends State<CadastroPreTreinoApp> {
  var _obscuro = true;
  var _obscuroRepetir = true;
  var hint = "Digite o nome Atleta";

  CadastroPreTreino cadastro = CadastroPreTreino("", "", "", "");

  TextEditingController senhaController = TextEditingController();
  TextEditingController repetirSenhaController = TextEditingController();
  List<String> _kOptions = <String>[
    'joão',
    'lamarca',
    'caio',
  ];

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Crawl"), value: "Crawl"),
      DropdownMenuItem(child: Text("Costas"), value: "Costas"),
    ];
    String? selectValue = 'Crawl';

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    textAlign: TextAlign.start,
                    'Cadastre um usuário',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
                    ),
                  ),
                  Text(
                    'Preencha as informações:',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                       
                        return const Iterable<String>.empty();
                      }
                      return _kOptions.where((String option) {
                        final inputText = textEditingValue.text.toLowerCase();
                        final optionText = option.toLowerCase();
                        return optionText.contains(inputText);
                      });
                    },
                    onSelected: (String selection) {},
                  ),
                  const SizedBox(
                    height: 50,
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
                      border: OutlineInputBorder(),
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
                  DropdownButtonFormField(
                    value: selectValue,
                    items: menuItems,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: (String? value) {
                      selectValue = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 23, 192, 204),
                        minimumSize: Size(200.0, 60.0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15.0), // Borda arredondada
                        ),
                      ),
                      child: const Text('Iniciar',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 197, 23, 0),
                        minimumSize: Size(200.0, 60.0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15.0), // Borda arredondada
                        ),
                      ),
                      child: const Text('Cancelar',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      onPressed: () {},
                    ),
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
