import 'package:desafio/model/atleta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    supportedLocales: [
      const Locale('pt'), // Defina o idioma e país desejados
    ],
    home: CadastroAtleta(),
  ));
}

class CadastroAtleta extends StatefulWidget {
  const CadastroAtleta({super.key});

  @override
  State<CadastroAtleta> createState() => _CadastroAtletaAppState();
}

class _CadastroAtletaAppState extends State<CadastroAtleta> {
  TextEditingController _dateController = TextEditingController();
  var format = DateFormat('MM/dd/yyyy');
  final _formKey = GlobalKey<FormState>();

  Atleta atleta = Atleta("", "", "", "", "", "", "", "", "", "", "", "", "", "",
      "", "", "", "", "", "", "", "", "", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Image.asset('assets/images/logoUnaerp.png', width: 200),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Termine seu cadastro',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 26),
                      ),
                    ),
                    Text(
                      'Preencha as informações:',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ),

                    TextField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: const OutlineInputBorder(),
                          labelText: 'Data de nascimento',
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        readOnly: true,
                        onTap: () {
                          _selectDate();
                        }),
                    //Campos dos forms
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        _dateController.text =
            DateFormat('dd/MM/yyyy', 'pt_BR').format(_picked);
        atleta.dataDeNascimento =
            DateFormat('dd/MM/yyyy', 'pt_BR').format(_picked);
      });
    }
  }
}
