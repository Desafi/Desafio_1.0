import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  const EstatisticaApp({super.key});

  @override
  State<EstatisticaApp> createState() => _EstatisticaAppState();
}

List<FlSpot> chartData = [
  FlSpot(0, 1),
  FlSpot(1, 3),
  FlSpot(2, 10),
  FlSpot(3, 7),
  FlSpot(4, 12),
  FlSpot(5, 13),
  FlSpot(6, 17),
  FlSpot(7, 15),
  FlSpot(8, 20),
];

class _EstatisticaAppState extends State<EstatisticaApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Text(
                  'Estatisticas',
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 26),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: LineChart(LineChartData(
                        titlesData: FlTitlesData(
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false))),
                        borderData: FlBorderData(show: true),
                        backgroundColor: Colors.white,
                        lineBarsData: [
                          LineChartBarData(
                            spots: chartData,
                            color: Colors.amber,
                            belowBarData: BarAreaData(show: true),
                            barWidth: 6,
                            isCurved: false,
                          )
                        ])),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
