import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  var atletas = [
    Atleta("Bruno", [150, 240, 253, 300, 321, 281, 322]),
    // Atleta("João", [322, 350, 290, 339, 400, 190, 320]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Charts"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: LineChart(LineChartData(
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: const AxisTitles(
                axisNameWidget: Text("Voltas"),
                sideTitles: SideTitles(showTitles: true),
              ),
              leftTitles: AxisTitles(
                axisNameWidget: const Text("Minutos"),
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: getLeftTitles,
                ),
              ),
            ),
            lineBarsData: atletas
                .map((e) => LineChartBarData(
                        spots: e.tempos.asMap().entries.map(
                      (entry) {
                        print(entry);
                        print(entry.key.toDouble());
                        return FlSpot(entry.key.toDouble(), entry.value);
                      },
                    ).toList()))
                .toList())),
      ),
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    int minutes = value ~/ 60;
    int seconds = (value * 60).toInt();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        "$minutes:$seconds",
        softWrap: false,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 7,
        ),
      ),
    );
  }
}

class Atleta {
  String nome;
  List<double> tempos;

  Atleta(this.nome, this.tempos);
}
