import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/desempenho.dart';
import 'package:desafio/screen/estatistica.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CompararAtletaApp(),
//     );
//   }
// }

class CompararAtletaApp extends StatefulWidget {
  const CompararAtletaApp({super.key});

  @override
  State<CompararAtletaApp> createState() => _CompararAtletaAppState();
}

bool _carregando = true;
final SearchController _searchController = SearchController();
final SearchController _searchController2 = SearchController();
List<Map<String, String>> _kOptions = [];
FirebaseFirestore db = FirebaseFirestore.instance;

class _CompararAtletaAppState extends State<CompararAtletaApp> {
  @override
  void initState() {
    PegarInformacaoAtleta();

    Firebase.initializeApp();
    super.initState();
  }

  Future<void> PegarInformacaoAtleta() async {
    QuerySnapshot atletasQuery = await db
        .collection('Usuarios')
        .where('Tipo', isEqualTo: 'Atleta')
        .where("Status", isEqualTo: "Aprovado")
        .get();
    _kOptions.clear();
    for (var doc in atletasQuery.docs) {
      String nomeAtleta = doc['Nome'];
      String emailAtleta = doc['Email'];
      String foto = doc['ImagemAtleta'];

      Map<String, String> atletaMap = {
        'Nome': nomeAtleta,
        'Email': emailAtleta,
        'Foto': foto,
      };

      _kOptions.add(atletaMap);
    }
    setState(() {
      _carregando = false;
    });
  }

  Widget _buildSearchBar(SearchController controller) {
    return SearchAnchor(
      isFullScreen: true,
      searchController: controller,
      builder: (BuildContext context, SearchController searchController) {
        return SearchBar(
          hintText: "Selecione o atleta",
          controller: searchController,
          padding: const MaterialStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          onTap: () async {
            searchController.openView();
          },
          leading: const Icon(Icons.search),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        if (controller.text.isEmpty) {
          if (_kOptions.length < 0) {
            return <Widget>[
              const Center(
                  child: Text('No search history.',
                      style: TextStyle(color: Colors.amber)))
            ];
          } else {
            return List<Widget>.generate(_kOptions.length, (int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(_kOptions[index]["Foto"].toString()),
                  ),
                  title: Text(
                    _kOptions[index]["Nome"].toString(),
                  ),
                  onTap: () {
                    controller.closeView(_kOptions[index]["Email"].toString());
                  },
                ),
              );
            });
          }
        } else {
          var pesquisa = controller.text.toLowerCase();

          List<Map<String, String>> filteredOptions = _kOptions.where((option) {
            String nome = option["Nome"].toString().toLowerCase();
            return nome.contains(pesquisa);
          }).toList();
          return List<Widget>.generate(filteredOptions.length, (int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(filteredOptions[index]["Foto"].toString()),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                Navigator.pop(context);
              }),
        ),
        body: _carregando == true
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.black, size: 200))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Compare!',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 36),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Escolha os atletas que deseja comparar.',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildSearchBar(_searchController),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildSearchBar(_searchController2),
                      const SizedBox(
                        height: 20,
                      ),
                      BotaoPrincipal(
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const EstatisticaApp()),
                            );
                          },
                          hintText: "Comparar",
                          radius: 12,
                          cor: Colors.blueAccent)
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
