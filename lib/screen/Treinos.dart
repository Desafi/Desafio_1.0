import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MeusTreinosApp(),
//     );
//   }
// }

class TreinosApp extends StatefulWidget {
  final List<Widget> cards;
  final String titulo;

  const TreinosApp({
    super.key,
    required this.cards,
    required this.titulo,
  });

  @override
  State<TreinosApp> createState() => _TreinosAppState();
}

class _TreinosAppState extends State<TreinosApp> {
  var _mm = true;

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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SearchAnchor(builder:
                          (BuildContext context, SearchController controller) {
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
                          trailing: const <Widget>[],
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
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _mm = !_mm;
                      });
                    },
                    child: IconButton(
                      icon: _mm
                          ? const Icon(Icons.arrow_drop_up)
                          : const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        setState(() {
                          _mm = !_mm;
                        });
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: widget.cards),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
