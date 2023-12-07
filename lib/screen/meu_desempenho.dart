import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/screen/estatistica.dart';
import 'package:desafio/widget/icones_treino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginApp(),
//     );
//   }
// }

class MeuDesempenhoApp extends StatefulWidget {
  const MeuDesempenhoApp({super.key});

  @override
  State<MeuDesempenhoApp> createState() => _MeuDesempenhoAppState();
}

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
List<String> datas = [];
String? _selectedItem;
AtletaDesempenho? _atleta;
String? mediaTempo;
String? maiorTempo;
String? menorTempo;

class _MeuDesempenhoAppState extends State<MeuDesempenhoApp> {
  @override
  void initState() {
    _buscarTreinos();
    super.initState();
  }

  Future<void> _buscarTreinos() async {
    datas.clear();
    await db
        .collection("Treinos")
        .doc(_auth.currentUser!.uid)
        .collection("TreinoAtleta")
        .get()
        .then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        setState(() {
          datas.add("${element.data()["HoraData"]}");
        });
      }
      if (datas.isNotEmpty) {
        setState(() {
          _selectedItem = datas.first;
        });
      }
    });
  }

  Future<AtletaDesempenho> _buscarDados() async {
    QuerySnapshot querySnapshot = await db
        .collection("Treinos")
        .doc(_auth.currentUser!.uid)
        .collection("TreinoAtleta")
        .where("HoraData", isEqualTo: _selectedItem)
        .get();

    List<double> tempos = [];

    for (var element in querySnapshot.docs) {
      if (element.data() != null) {
        Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey("TempoVoltasSegundos")) {
          List<dynamic> lista1 = data["TempoVoltasSegundos"];

          tempos
              .addAll(lista1.map((e) => double.tryParse(e.toString()) ?? 0.0));
        }
      }
    }

    return AtletaDesempenho(tempos);
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'Desempenho!',
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 36),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Selecione uma data e veja seu desempenho.',
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                icon: const Icon(Icons.arrow_drop_down_rounded),
                isExpanded: false,
                value: _selectedItem,
                items: datas.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value;
                  });
                },
              ),
              FutureBuilder<AtletaDesempenho>(
                  future: _buscarDados(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      _atleta = snapshot.data;
                      return _atleta == null
                          ? const Center(child: Text('Nenhum treino encontrado!'))
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 500,
                                    child: LineChart(
                                      LineChartData(
                                        minY: 0,
                                        maxY: 600,
                                        minX: 0,
                                        titlesData: const FlTitlesData(
                                          rightTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                  showTitles: false)),
                                          topTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                  showTitles: false)),
                                          bottomTitles: AxisTitles(
                                            axisNameWidget: Text(
                                              "Voltas",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                            ),
                                          ),
                                          leftTitles: AxisTitles(
                                            axisNameWidget: Text(
                                                "Minutos",
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
                                        lineBarsData: [
                                          LineChartBarData(
                                            color: Colors.blueAccent,
                                            belowBarData:
                                                BarAreaData(show: true),
                                            barWidth: 6,
                                            isCurved: true,
                                            spots: _atleta!.tempos
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              return FlSpot(
                                                  entry.key.toDouble(),
                                                  entry.value);
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    IconesTreino(
                                      hintText: "Menor volta:",
                                      informacao: _transformarMinutos(
                                          _atleta!.tempos.first),
                                      icone: const Icon(
                                        Icons.star,
                                        size: 40,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    IconesTreino(
                                        hintText: "Maior volta:",
                                        informacao: _transformarMinutos(
                                            _atleta!.tempos.last),
                                        icone: const Icon(
                                          Icons.pool_outlined,
                                          size: 40,
                                          color: Colors.blue,
                                        )),
                                    IconesTreino(
                                      hintText: "Média de tempo:",
                                      informacao: _transformarMinutos(_atleta!
                                              .tempos
                                              .reduce((value, element) =>
                                                  value + element) /
                                          _atleta!.tempos.length),
                                      icone: const Icon(
                                        Ionicons.timer_outline,
                                        size: 40,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                    }
                  }),
            ],
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

class AtletaDesempenho {
  List<double> tempos;

  AtletaDesempenho(this.tempos);
}

_transformarMinutos(double tempo) {
  int minutes = tempo ~/ 60;
  int seconds = (tempo % 60).toInt();
  return "$minutes:$seconds";
}
