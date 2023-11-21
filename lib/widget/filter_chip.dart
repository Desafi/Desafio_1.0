import 'package:flutter/material.dart';

class BtnFiltro extends StatefulWidget {
  final Function(String) onFilterSelected;
  final List<String> lista;

  BtnFiltro({Key? key,
   required this.onFilterSelected,
   required this.lista
   }) : super(key: key);

  @override
  _BtnFiltroState createState() => _BtnFiltroState();
}

class _BtnFiltroState extends State<BtnFiltro> {
  List<String> filtrosSelecionados = [];

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
          selected: filtrosSelecionados.contains(exercise),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                filtrosSelecionados.add(exercise);
                widget.onFilterSelected(filtrosSelecionados.toString());
              } else {
                filtrosSelecionados.remove(exercise);
                widget.onFilterSelected(filtrosSelecionados.toString());
              }
            });
          },
        );
      }).toList(),
    );
  }
}
