import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/cadastro.dart';
import 'package:desafio/screen/cronometro.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:desafio/widget/scaffolds.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:desafio/model/preTreino.dart';
import 'package:intl/intl.dart';

// void main() {
//   runApp(const MyApp());
// }

String? selectValue;
final FirebaseAuth _auth = FirebaseAuth.instance;

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: CadastroPreTreinoApp(),
//     );
//   }
// }

class CadastroPreTreinoApp extends StatefulWidget {
  const CadastroPreTreinoApp({super.key});

  @override
  State<CadastroPreTreinoApp> createState() => _CadastroPreTreinoAppState();
}

List<Map<String, String>> _kOptions = [];

FirebaseFirestore db = FirebaseFirestore.instance;

bool carregando = false;

class _CadastroPreTreinoAppState extends State<CadastroPreTreinoApp> {
  final SearchController _searchController = SearchController();
  CadastroPreTreino cadastro = CadastroPreTreino("", "", "", "", "");

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Crawl", child: Text("Crawl")),
      const DropdownMenuItem(value: "Costas", child: Text("Costas")),
      const DropdownMenuItem(value: "Peito", child: Text("Peito")),
      const DropdownMenuItem(value: "Borboleta", child: Text("Borboleta")),
      const DropdownMenuItem(value: "Medley", child: Text("Medley")),
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

                  Text(
                    textAlign: TextAlign.start,
                    'Cadastro pré-treino',
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

                  //Pesquisar
                  SearchAnchor(
                    isFullScreen: true,
                    searchController: _searchController,
                    builder: (BuildContext context,
                        SearchController searchController) {
                      return SearchBar(
                        hintText: "Selecione o atleta",
                        controller: searchController,
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        onTap: () async {
                          searchController.openView();
                          await PegarInformacaoAtleta();
                        },
                        leading: const Icon(Icons.search),
                      );
                    },
                    suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                      if (controller.text.isEmpty) {
                        if (_kOptions.length < 0) {
                          return <Widget>[
                            const Center(
                                child: Text('No search history.',
                                    style: TextStyle(color: Colors.amber)))
                          ];
                        } else {
                          return List<Widget>.generate(_kOptions.length,
                              (int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      _kOptions[index]["Foto"].toString()),
                                ),
                                title: Text(
                                  _kOptions[index]["Nome"].toString(),
                                ),
                                onTap: () {
                                  controller.closeView(
                                      _kOptions[index]["Email"].toString());
                                },
                              ),
                            );
                          });
                        }
                      } else {
                        var pesquisa = controller.text.toLowerCase();

                        List<Map<String, String>> filteredOptions =
                            _kOptions.where((option) {
                          String nome = option["Nome"].toString().toLowerCase();
                          return nome.contains(pesquisa);
                        }).toList();
                        return List<Widget>.generate(filteredOptions.length,
                            (int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    filteredOptions[index]["Foto"].toString()),
                              ),
                              title: Text(
                                filteredOptions[index]["Nome"].toString(),
                              ),
                              onTap: () {
                                controller.closeView(
                                  filteredOptions[index]["Email"].toString(),
                                );
                              },
                            ),
                          );
                        });
                      }
                    },
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
                      cadastro.frequenciaCardiacaInicio = value;
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
                        db
                            .collection("Usuarios")
                            .where("Email", isEqualTo: _searchController.text)
                            .limit(1)
                            .get()
                            .then((querySnapshot) {
                          if (querySnapshot.docs.isEmpty) {
                            //Email nao existe
                            Mensagem(context, "E-mail não existe", Colors.red);
                          } else {
                            var userId = querySnapshot.docs[0].id;
                            var userData = querySnapshot.docs[0].data();
                            String nome = userData["Nome"];
                            String email = userData["Email"];
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => CronometroApp(
                                      emailAtleta: email,
                                      nomeAtleta: nome,
                                      uidAtleta: userId,
                                      emailAplicante:
                                          _auth.currentUser!.email.toString(),
                                      frequenciaInicio: cadastro
                                          .frequenciaCardiacaInicio
                                          .toString(),
                                      estiloTreino:
                                          cadastro.estiloTreino.toString())),
                            );
                            _searchController.text = "";
                          }
                        });
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

PegarInformacaoAtleta() async {
  QuerySnapshot atletasQuery = await db
      .collection('Usuarios')
      .where('Tipo', isEqualTo: 'Atleta')
      .where("Cadastrado", isEqualTo: "1")
      .get();
  _kOptions.clear();
  for (var doc in atletasQuery.docs) {
    String nomeAtleta = doc['Nome'];
    String emailAtleta = doc['Email'];
    String foto = doc['ImagemAtleta'];
    print(foto);

    Map<String, String> atletaMap = {
      'Nome': nomeAtleta,
      'Email': emailAtleta,
      'Foto': foto,
    };

    _kOptions.add(atletaMap);
  }
}

String DataAgora() {
  DateTime agora = DateTime.now();
  String formato = DateFormat('dd-MM-yyyy - kk:mm:ss').format(agora);
  return formato.toString();
}
