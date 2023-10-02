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
      home: MeusTreinosApp(),
    );
  }
}

class MeusTreinosApp extends StatefulWidget {
  const MeusTreinosApp({super.key});

  @override
  State<MeusTreinosApp> createState() => _MeusTreinosAppState();
}

class _MeusTreinosAppState extends State<MeusTreinosApp> {
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
              Center(
                child: Text(
                  'Meus Treinos',
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
                  trailing: <Widget>[],
                );
              }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                List<String> items = [
                  'Crawl',
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
                            color: Color(0xFFF7F2FA),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
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
                                Text('Estilo de treino: borboleta',
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Data do treino: 20/09/2023',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(
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
                            color: Color(0xFFF7F2FA),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
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
                                Text('Estilo de treino: Crawl',
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Data do treino: 20/08/2023',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(
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
