import 'package:desafio/model/cadastro.dart';
import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> menuItems = [
  const DropdownMenuItem(value: "Treinador", child: Text("Treinador")),
  const DropdownMenuItem(value: "Atleta", child: Text("Atleta")),
];
String? selectValue;

Cadastro cadastro = Cadastro("", "", "","");

class DropDownCadastro extends StatelessWidget {
  final Function()? onTap;

  const DropDownCadastro({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<String>(
        value: null,
        items: menuItems,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Este campo é obrigatório!";
          }
          cadastro.tipo = value;
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: (String? value) {
          selectValue = value;
        },
        hint: const Text('Selecione uma opção'),
      );
}
