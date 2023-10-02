import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginApp(),
    );
  }
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: NavigationBar(
          indicatorColor: Colors.blueAccent,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.mode_edit_outline_outlined),
              label: 'Cadastrar atleta',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_pin_outlined),
              label: 'Gerenciar atleta',
            ),
            NavigationDestination(
              icon: Icon(Icons.pool),
              label: 'Realizar treino',
            ),
            NavigationDestination(
              icon: Icon(Icons.article_outlined),
              label: 'Gerenciar treinos',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Perfil\n',
            ),
          ],
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
