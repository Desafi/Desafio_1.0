import 'package:desafio/model/atleta.dart';
import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> estadosBrasil = [
  const DropdownMenuItem(value: "UF", child: Text("UF")),
  const DropdownMenuItem(value: "AC", child: Text("AC")),
  const DropdownMenuItem(value: "AL", child: Text("AL")),
  const DropdownMenuItem(value: "AP", child: Text("AP")),
  const DropdownMenuItem(value: "AM", child: Text("AM")),
  const DropdownMenuItem(value: "BA", child: Text("BA")),
  const DropdownMenuItem(value: "CE", child: Text("CE")),
  const DropdownMenuItem(value: "DF", child: Text("DF")),
  const DropdownMenuItem(value: "ES", child: Text("ES")),
  const DropdownMenuItem(value: "GO", child: Text("GO")),
  const DropdownMenuItem(value: "MA", child: Text("MA")),
  const DropdownMenuItem(value: "MT", child: Text("MT")),
  const DropdownMenuItem(value: "MS", child: Text("MS")),
  const DropdownMenuItem(value: "MG", child: Text("MG")),
  const DropdownMenuItem(value: "PA", child: Text("PA")),
  const DropdownMenuItem(value: "PB", child: Text("PB")),
  const DropdownMenuItem(value: "PR", child: Text("PR")),
  const DropdownMenuItem(value: "PE", child: Text("PE")),
  const DropdownMenuItem(value: "PI", child: Text("PI")),
  const DropdownMenuItem(value: "RJ", child: Text("RJ")),
  const DropdownMenuItem(value: "RN", child: Text("RN")),
  const DropdownMenuItem(value: "RS", child: Text("RS")),
  const DropdownMenuItem(value: "RO", child: Text("RO")),
  const DropdownMenuItem(value: "RR", child: Text("RR")),
  const DropdownMenuItem(value: "SC", child: Text("SC")),
  const DropdownMenuItem(value: "SP", child: Text("SP")),
  const DropdownMenuItem(value: "SE", child: Text("SE")),
  const DropdownMenuItem(value: "TO", child: Text("TO")),
];

class DropDownEstados extends StatelessWidget {
  final Function()? onTap;
  final FormFieldValidator<String>? validator;
  final TextEditingController formController;

  const DropDownEstados({
    super.key,
    required this.formController,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<String>(
        value: formController.text.isEmpty ? "UF" : formController.text,
        items: estadosBrasil,
        validator: validator,
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
        onChanged: (String? value) {},
        hint: const Text('Selecione'),
      );
}
