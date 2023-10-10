import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text(
                  'Atletas',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  hintText: ("Digite o nome do atleta.."),
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  trailing: const <Widget>[],
                );
              }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                List<String> items = [
                  'João',
                  'Caio',
                  'Gabriel',
                  'Luiz',
                ];
                return items.map((String item) {
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                }).toList();
              }),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Container(
                        width: 400,
                        height: 100,
                        decoration: BoxDecoration(
                            color: const Color(0xFFF7F2FA),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage('assets/images/person.jpg'),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Nome: João Antonio',
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Telefone: 1699595994',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: 400,
                        height: 100,
                        decoration: BoxDecoration(
                            color: const Color(0xFFF7F2FA),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage('assets/images/person.jpg'),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Nome: Caio Aluizio',
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Telefone: 16558551541',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}