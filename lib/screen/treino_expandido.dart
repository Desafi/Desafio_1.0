import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/widget/icones_treino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: TreinoExpandidoApp(),
//     );
//   }
// }

FirebaseFirestore db = FirebaseFirestore.instance;
Map<String, dynamic>? treino;
String? maiorTempo;
String? menorTempo;
bool carregando = true;

class TreinoExpandidoApp extends StatefulWidget {
  String id;
  TreinoExpandidoApp({required this.id, super.key});

  @override
  State<TreinoExpandidoApp> createState() => _TreinoExpandidoAppState();
}

class _TreinoExpandidoAppState extends State<TreinoExpandidoApp> {
  @override
  void initState() {
    _carregaInfoTreino();
    super.initState();
  }

  Future<void> _carregaInfoTreino() async {
    await db.collectionGroup("TreinoAtleta").get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.id == widget.id) {
          setState(() {
            treino = doc.data();
          });
        }
      });
    });
    List list = treino!["TempoVoltas"];
    list.sort();
    setState(() {
      maiorTempo = list.last;
      menorTempo = list.first;
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text("Informações do treino"),
      ),
      backgroundColor: Colors.white,
      body: carregando == true
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.black, size: 200))
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Informações da prova',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),

                      Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          IconesTreino(
                            hintText: "Data do treino:",
                            informacao: treino!["DataTreino"],
                            icone: Icon(
                              Icons.date_range_outlined,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                          IconesTreino(
                              hintText: "Tipo:",
                              informacao: treino!["TipoNado"],
                              icone: Icon(
                                Icons.pool_outlined,
                                size: 50,
                                color: Colors.blue,
                              )),
                          IconesTreino(
                            hintText: "Batimento início:",
                            informacao: "${treino!["FrequenciaInicio"]} bpm",
                            icone: Icon(
                              Ionicons.heart,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                          IconesTreino(
                            hintText: "Menor tempo:",
                            informacao: menorTempo!,
                            icone: Icon(
                              Ionicons.time_sharp,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                          IconesTreino(
                            hintText: "Maior tempo:",
                            informacao: maiorTempo!,
                            icone: Icon(
                              Ionicons.timer_sharp,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                          IconesTreino(
                            hintText: "Batimento final: ",
                            informacao: treino!["FrequenciaFinal"],
                            icone: Icon(
                              Ionicons.heart_circle_sharp,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                          IconesTreino(
                            hintText: "Avaliador:",
                            informacao: treino!["EmailAplicante"],
                            icone: Icon(
                              Ionicons.mail,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [

                      //   ],
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Voltas',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Tempo Volta',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Tempo Geral',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 400.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFFd3dfe4),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 25, left: 40),
                          child: ListView.builder(
                            itemCount: treino!["TempoVoltas"].length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Text(
                                  "${index + 1}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                title: Text(treino!["TempoVoltas"][index],
                                    style: TextStyle(fontSize: 16)),
                                trailing: Text(treino!["TempoGeral"][index],
                                    style: TextStyle(fontSize: 16)),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
