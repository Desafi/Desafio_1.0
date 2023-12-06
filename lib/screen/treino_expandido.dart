import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/model/atleta.dart';
import 'package:desafio/screen/estatistica.dart';
import 'package:desafio/widget/icones_treino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
Map<String, dynamic>? treino;
String? maiorTempo;
String? menorTempo;
bool carregando = true;
double? segundos;

List<double> voltas = [];
// List<double> voltasFinais = [];
// List<double> voltasFinaisGeral = [];
// List<FlSpot> spots = [];

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

    List<dynamic> lista = treino!["TempoVoltasSegundos"];
    setState(() {
      voltas = lista.map((e) {
        return double.parse(e.toString());
      }).toList();
    });

    List list = List.from(treino!["TempoVoltas"]);

    list.sort();
    setState(() {
      maiorTempo = list.last;
      menorTempo = list.first;
      // _trasnformarVoltas();
      carregando = false;
    });
  }

  // Future<void> _trasnformarVoltas() async {
  //   List voltas = treino!["TempoVoltasSegundos"];
  //   List voltasGeral = treino!["TempoGeralSegundos"];
  //   List<double> voltasFinal = [];

  //   for (int i = 0; i < voltas.length; i++) {
  //     int minutos = voltas[i] ~/ 60;
  //     int segundos = (voltas[i] % 60).toInt();

  //     int minutosGeral = voltasGeral[i] ~/ 60;
  //     int segundosGeral = (voltasGeral[i] % 60).toInt();

  //     String resultado = "${minutos}.${segundos}";
  //     String resultadoGeral = "${minutosGeral}.${segundosGeral}";

  //     double result = double.parse(resultado);
  //     double resultGeral = double.parse(resultadoGeral);

  //     spots.add(FlSpot(result, i.toDouble()));

  //     // voltasFinal.add(result);
  //     // voltasFinaisGeral.add(resultGeral);

  //     // double minutosDouble = minutos.toDouble();
  //     // double segundosDouble = segundos.toDouble();

  //     // double finad = minutosDouble + segundosDouble;

  //     // print(finad);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var atletas = [
      Atleta(voltas),
    ];
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
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
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
                      const Text(
                        'Gráfico das voltas',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 500,
                          child: LineChart(
                            LineChartData(
                              minY: 0,
                              maxY: 600,
                              minX: 1,
                              titlesData: FlTitlesData(
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: const AxisTitles(
                                  axisNameWidget: Text(
                                    "Voltas",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  axisNameWidget: const Text("Minutos",
                                      style: TextStyle(fontSize: 15)),
                                  sideTitles: SideTitles(
                                    reservedSize: 50,
                                    showTitles: true,
                                    getTitlesWidget: getLeftTitles,
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(show: true),
                              backgroundColor: Colors.white,
                              lineBarsData: atletas
                                  .map((e) => LineChartBarData(
                                      color: Colors.blueAccent,
                                      belowBarData: BarAreaData(show: true),
                                      barWidth: 6,
                                      isCurved: true,
                                      spots: e.tempos
                                          .asMap()
                                          .entries
                                          .map((entry) => FlSpot(
                                                entry.key.toDouble() + 1,
                                                entry.value,
                                              ))
                                          .toList()))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

// Widget getLeftTitles(double value, TitleMeta meta) {
//   int minutes = value ~/ 60;
//   int seconds = (value % 60).toInt();
//   return SideTitleWidget(
//     axisSide: meta.axisSide,
//     child: Text(
//       "$minutes:$seconds",
//       softWrap: false,
//       style: const TextStyle(
//         color: Colors.grey,
//         fontWeight: FontWeight.bold,
//         fontSize: 14,
//       ),
//     ),
//   );
// }

class Atleta {
  List<double> tempos;

  Atleta(this.tempos);
}
