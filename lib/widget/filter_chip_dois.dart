import 'package:flutter/material.dart';

class BtnFiltroDois extends StatefulWidget {
  final Function(String) onFilterSelected;
  final List<String> lista;

  BtnFiltroDois({Key? key, required this.onFilterSelected, required this.lista})
      : super(key: key);

  @override
  _BtnFiltroDoisState createState() => _BtnFiltroDoisState();
}

class _BtnFiltroDoisState extends State<BtnFiltroDois> {
  String? filtroSelecionado;

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
          selected: filtroSelecionado == exercise,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                filtroSelecionado = exercise;
                widget.onFilterSelected(filtroSelecionado!);
              } else {
                filtroSelecionado = null;
                widget.onFilterSelected('');
              }
            });
          },
        );
      }).toList(),
    );
  }
}
