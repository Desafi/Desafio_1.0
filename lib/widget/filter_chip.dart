import 'package:flutter/material.dart';

class BtnFiltro extends StatefulWidget {
  final Function(List<String>) onFilterSelected;
  final List<String> lista;
  final List<String> selecionado;

  BtnFiltro(
      {Key? key,
      required this.onFilterSelected,
      required this.lista,
      required this.selecionado})
      : super(key: key);

  @override
  _BtnFiltroState createState() => _BtnFiltroState();
}

class _BtnFiltroState extends State<BtnFiltro> {
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
          selected: widget.selecionado.contains(exercise),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                widget.selecionado.add(exercise);
              } else {
                if (widget.selecionado.length != 1)
                  widget.selecionado.remove(exercise);
              }
              widget.onFilterSelected(widget.selecionado);
            });
          },
        );
      }).toList(),
    );
  }
}
