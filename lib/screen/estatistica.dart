import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/comparar_atletas.dart';
import 'package:desafio/screen/nao_encontrado.dart';
import 'package:desafio/widget/icones_treino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
//       home: DesempenhoApp(),
//     );
//   }
// }

class EstatisticaApp extends StatefulWidget {
  String email;
  String emailComparar;
  String data;
  Map<String, dynamic> atleta1;
  Map<String, dynamic> atleta2;

  EstatisticaApp(
      {required this.email,
      required this.emailComparar,
      required this.data,
      required this.atleta1,
      required this.atleta2,
      super.key});

  @override
  State<EstatisticaApp> createState() => _EstatisticaAppState();
}

bool _carregando = true;
List<String> datas = [];
List<double> voltas1 = [];
List<double> voltas2 = [];
String? maiorVolta1;
String? maiorVolta2;
String? menorVolta1;
String? menorVolta2;
String? mediaVoltaAt1;
String? mediaVoltaAt2;

FirebaseFirestore db = FirebaseFirestore.instance;

class _EstatisticaAppState extends State<EstatisticaApp> {
  @override
  void initState() {
    _carregarInformacoes();
    super.initState();
  }

  _carregarInformacoes() {
    List<dynamic> lista1 = atleta1["TempoVoltasSegundos"];
    List<dynamic> lista2 = atleta2["TempoVoltasSegundos"];

    setState(() {
      voltas1 = lista1.map((e) {
        return double.parse(e.toString());
      }).toList();

      voltas2 = lista2.map((e) {
        return double.parse(e.toString());
      }).toList();

      var listaDouble1 = List.from(voltas1);
      var listaDouble2 = List.from(voltas2);

      listaDouble1.sort();
      menorVolta1 = _transformarMinutos(listaDouble1.first);
      maiorVolta1 = _transformarMinutos(listaDouble1.last);

      listaDouble2.sort();
      menorVolta2 = _transformarMinutos(listaDouble2.first);
      maiorVolta2 = _transformarMinutos(listaDouble2.last);

      double mediaVolta1 =
          (listaDouble1.reduce((value, element) => value + element)) /
              listaDouble1.length;
      double mediaVolta2 =
          (listaDouble2.reduce((value, element) => value + element)) /
              voltas2.length;

      int media1 = int.parse(mediaVolta1.ceil().toString());
      int media2 = int.parse(mediaVolta2.ceil().toString());

      mediaVoltaAt1 = _transformarMinutos(double.parse(media1.toString()));
      mediaVoltaAt2 = _transformarMinutos(double.parse(media2.toString()));

      _carregando = false;
    });
  }

  _transformarMinutos(double tempo) {
    int minutes = tempo ~/ 60;
    int seconds = (tempo % 60).toInt();
    return "${minutes}:${seconds}";
  }

  @override
  Widget build(BuildContext context) {
    var atletas = [
      AtletaEstatistica(1, atleta1["NomeAtleta"], voltas1),
      AtletaEstatistica(2, atleta2["NomeAtleta"], voltas2),
    ];

    return _carregando == true
        ? Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.black, size: 200))
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () async {
                      Navigator.pop(context);
                    }),
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Estatisticas',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 26),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Aqui você analisa as estatísticas dos atletas durante a prova.',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Dados do ${atleta1["NomeAtleta"]}',
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ),
                          IconesTreino(
                            hintText: "Menor tempo:",
                            informacao: menorVolta1.toString(),
                            icone: Icon(
                              Icons.star,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                          IconesTreino(
                              hintText: "Maior tempo:",
                              informacao: maiorVolta1.toString(),
                              icone: Icon(
                                Icons.pool_outlined,
                                size: 50,
                                color: Colors.blue,
                              )),
                          IconesTreino(
                            hintText: "Média de tempo:",
                            informacao: mediaVoltaAt1.toString(),
                            icone: Icon(
                              Ionicons.timer_outline,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'Dados do ${atleta2["NomeAtleta"]}',
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ),
                          IconesTreino(
                            hintText: "Menor tempo:",
                            informacao: menorVolta2.toString(),
                            icone: Icon(
                              Icons.star,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                          IconesTreino(
                              hintText: "Maior tempo:",
                              informacao: maiorVolta2.toString(),
                              icone: Icon(
                                Icons.pool_outlined,
                                size: 50,
                                color: Colors.blue,
                              )),
                          IconesTreino(
                            hintText: "Média de tempo:",
                            informacao: mediaVoltaAt2.toString(),
                            icone: Icon(
                              Ionicons.timer_outline,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 500,
                              child: LineChart(
                                LineChartData(
                                  minY: 0,
                                  maxY: 600,
                                  minX: 0,
                                  titlesData: FlTitlesData(
                                    rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                    topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
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
                                          color: e.id == 1
                                              ? Colors.blueAccent
                                              : Colors.amber,
                                          belowBarData: BarAreaData(show: true),
                                          barWidth: 6,
                                          isCurved: true,
                                          spots: e.tempos
                                              .asMap()
                                              .entries
                                              .map((entry) => FlSpot(
                                                    entry.key.toDouble(),
                                                    entry.value,
                                                  ))
                                              .toList()))
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: atletas.map((e) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      color: e.id == 1
                                          ? Colors.blueAccent
                                          : Colors.amber,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      e.nome,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

Widget getLeftTitles(double value, TitleMeta meta) {
  int minutes = value ~/ 60;
  int seconds = (value % 60).toInt();
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      "$minutes:$seconds",
      softWrap: false,
      style: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    ),
  );
}

class AtletaEstatistica {
  int id;
  String nome;
  List<double> tempos;

  AtletaEstatistica(this.id, this.nome, this.tempos);
}
