import 'package:flutter/material.dart';

class BtnFiltro extends StatefulWidget {
  final String text;

  BtnFiltro({Key? key, required this.text}) : super(key: key);

  @override
  _BtnFiltroState createState() => _BtnFiltroState();
}

class _BtnFiltroState extends State<BtnFiltro> {
  bool selecionado = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.text),
      selected: selecionado,
      onSelected: (selected) {
        setState(() {
          selecionado = selected;
        });
      },
    );
  }
}