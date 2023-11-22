import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TesteApp(),
    );
  }
}

class TesteApp extends StatefulWidget {
  const TesteApp({super.key});

  @override
  State<StatefulWidget> createState() => _TesteAppState();
}

class _TesteAppState extends State<TesteApp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Flexible(
              child: Container(
                color: Colors.amber,
              ),
            ),
            CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/person.jpg')),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 500,
                  height: 200,
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
