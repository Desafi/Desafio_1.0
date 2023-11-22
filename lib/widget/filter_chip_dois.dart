import 'package:flutter/material.dart';

class BtnFiltroDois extends StatefulWidget {
  final Function(String) onFilterSelected;
  final List<String> lista;
  String? tempoSelecionado;

  BtnFiltroDois({Key? key, required this.onFilterSelected, required this.lista,
  required this.tempoSelecionado})
      : super(key: key);

  @override
  _BtnFiltroDoisState createState() => _BtnFiltroDoisState();
}

class _BtnFiltroDoisState extends State<BtnFiltroDois> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      children: widget.lista.map((exercise) {
        return FilterChip(
          label: Text(
            exercise,
            style: TextStyle(fontSize: 16),
          ),
          selected: widget.tempoSelecionado == exercise,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                widget.tempoSelecionado = exercise;
                widget.onFilterSelected(widget.tempoSelecionado!);
              } else {
                widget.tempoSelecionado = null;
                widget.onFilterSelected('');
              }
            });
          },
        );
      }).toList(),
    );
  }
}
