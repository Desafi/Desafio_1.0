import 'package:flutter/material.dart';

class MeusUsers extends StatefulWidget {
  final List<Widget> cards;
  final String titulo;
  final String hintInput;

  MeusUsers({
    super.key,
    required this.cards,
    required this.titulo,
    required this.hintInput,
  });

  @override
  State<MeusUsers> createState() => _MeusUsersState();
}

class _MeusUsersState extends State<MeusUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                    widget.titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SearchAnchor(builder:
                    (BuildContext context, SearchController controller) {
                  return SearchBar(
                    hintText: (widget.hintInput),
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
                      children: widget.cards),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
