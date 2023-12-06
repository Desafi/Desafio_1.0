import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/cronometro.dart';
import 'package:desafio/screen/estatistica.dart';
import 'package:desafio/screen/nao_encontrado.dart';
import 'package:desafio/screen/primeiro_acesso.dart';
import 'package:desafio/screen/tela_nao_encontrada.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt'),
      ],
      title: 'Flutter Date Picker Example',
      home: CompararAtletaApp(),
    );
  }
}

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
final TextEditingController _dateController = TextEditingController();

String? idAtleta;
String? idAtleta2;
Map<String, dynamic> atleta1 = {};
Map<String, dynamic> atleta2 = {};

class _CompararAtletaAppState extends State<CompararAtletaApp> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    PegarInformacaoAtleta();
    Firebase.initializeApp();
    super.initState();
  }

  Future<void> _pegarId() async {
    await db
        .collection("Usuarios")
        .where("Email", isEqualTo: _searchController.text)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          idAtleta = doc.id;
        });
      });
    });
    await db
        .collection("Usuarios")
        .where("Email", isEqualTo: _searchController2.text)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          idAtleta2 = doc.id;
        });
      });
    });
    _pegarReferencias();
  }

  Future<void> _pegarReferencias() async {
    await db
        .collection("Treinos")
        .doc(idAtleta)
        .collection("TreinoAtleta")
        .where("DataTreino", isEqualTo: _dateController.text)
        .limit(1)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        atleta1 = doc.data();
      });
    });
    await db
        .collection("Treinos")
        .doc(idAtleta2)
        .collection("TreinoAtleta")
        .where("DataTreino", isEqualTo: _dateController.text)
        .limit(1)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        atleta2 = doc.data();
      });
    });

    _verificaExistencia();
  }

  Future<void> _verificaExistencia() async {
    if (atleta1.isEmpty || atleta2.isEmpty) {
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const NaoEncontradoTreino()),
      );
      resetaVariaveis();
    } else {
      await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => EstatisticaApp(
                  email: _searchController.text,
                  emailComparar: _searchController2.text,
                  data: _dateController.text,
                  atleta1: atleta1,
                  atleta2: atleta2,
                )),
      );
      resetaVariaveis();
    }
  }

  resetaVariaveis() {
    setState(() {
      idAtleta = '';
      idAtleta2 = '';
      atleta1.clear();
      atleta2.clear();
      _searchController.text = '';
      _searchController2.text = '';
      _dateController.text = '';
    });
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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('pt'),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat(
          'dd/MM/yyyy',
        ).format(picked);
      });
    }
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
                      TextField(
                        keyboardType: TextInputType.datetime,
                        controller: _dateController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_today),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: const OutlineInputBorder(),
                          labelText: 'Data do treino',
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        onTap: () => _selectDate(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BotaoPrincipal(
                          onTap: () async {
                            await _pegarId();
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
