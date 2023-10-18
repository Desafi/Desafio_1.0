import 'package:desafio/model/atleta.dart';
import 'package:desafio/widget/BotaoAdicionar.dart';
import 'package:desafio/widget/Scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

void main() {
  runApp(const MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    supportedLocales: [
      Locale('pt'), // Defina o idioma e país desejados
    ],
    home: CadastroAtleta(),
  ));
}

String? valorSexo;
String? valorEstado;

class CadastroAtleta extends StatefulWidget {
  const CadastroAtleta({super.key});

  @override
  State<CadastroAtleta> createState() => _CadastroAtletaAppState();
}

class _CadastroAtletaAppState extends State<CadastroAtleta> {
  final TextEditingController _textController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  var cepFormatter = MaskTextInputFormatter(
      mask: '#####-###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var cpfFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var rgFormatter = MaskTextInputFormatter(
      mask: '##.###.###-#',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var celualarFormatter = MaskTextInputFormatter(
      mask: '(##) # ####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "Feminino", child: Text("Feminino")),
    const DropdownMenuItem(value: "Masculino", child: Text("Masculino")),
    const DropdownMenuItem(value: "Outro", child: Text("Outro")),
  ];

  List<DropdownMenuItem<String>> telefones = [
    const DropdownMenuItem(
        value: "Número Adicional", child: Text("Numero Adicional")),
    const DropdownMenuItem(
        value: "Número Residencial", child: Text("Numero Residencial")),
    const DropdownMenuItem(
        value: "Número Local de Trabalho",
        child: Text("Número Local de Trabalho")),
    const DropdownMenuItem(value: "Número Pai", child: Text("Número Pai")),
    const DropdownMenuItem(value: "Número Mae", child: Text("Número Mae")),
  ];

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
  final TextEditingController _dateController = TextEditingController();
  var format = DateFormat('MM/dd/yyyy');
  final _formKey = GlobalKey<FormState>();

  List<Widget> camposAdicionais = [];

  TextEditingController txtCep = TextEditingController();

  Atleta atleta = Atleta("", "", "", "", "", "", "", "", "", "", "", "", "", "",
      "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

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
                    const SizedBox(
                      height: 20,
                    ),

                    TextField(
                        keyboardType: TextInputType.datetime,
                        controller: _dateController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_today),
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
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [celualarFormatter],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.numeroDoCelular = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Número de celular',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [celualarFormatter],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.numeroDoCelular = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Número de emergência',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.nacionalidade = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Nacionalidade',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.naturalidade = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Naturalidade',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //nacionalidade
                    //naturalidade

                    TextFormField(
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [cpfFormatter],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.cpf = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'CPF',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      inputFormatters: [rgFormatter],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.rg = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'RG',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                      value: null,
                      items: menuItems,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.sexo = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: (String? value) {
                        valorSexo = value;
                      },
                      hint: const Text('Selecione uma opção'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      inputFormatters: [cepFormatter],
                      controller: txtCep,
                      onChanged: (value) {
                        if (value.length == 9) {
                          BuscarCep();
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.cep = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Cep',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: cidadeController,
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo é obrigatório!";
                              }
                              atleta.cidade = value;
                              return null;
                            },
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                              border: const OutlineInputBorder(),
                              labelText: 'Cidade',
                              labelStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            value: estadoController.text.isEmpty
                                ? "UF"
                                : estadoController.text,
                            items: estadosBrasil,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == "UF") {
                                return "Este campo é obrigatório!";
                              }
                              atleta.estado = value;
                              return null;
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            onChanged: (String? value) {
                              valorEstado = value;
                            },
                            hint: const Text('Selecione'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: bairroController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.bairro = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Bairro',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: enderecoController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.endereco = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Endereço',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.convenioMedico = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Convenio Médico',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.estilos = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Estilo natação',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.prova = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Prova atleta',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      obscureText: false,
                      validator: (value) {
                        atleta.nomeDaMae = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Nome da mãe',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      validator: (value) {
                        atleta.nomeDoPai = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Nome do pai',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      validator: (value) {
                        atleta.clubeDeOrigem = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Clube de origem',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      validator: (value) {
                        atleta.alergiaAMedicamentos = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Alergia a medicamentos',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      obscureText: false,
                      readOnly: true,
                      validator: (value) {
                        atleta.imagemAtestado = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.image),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Foto atestado',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          //abrirCamera();
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(
                                              Icons.camera_alt_outlined,
                                              size: 70,
                                            ),
                                            Text(
                                              "Tirar foto",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          //abrirGaleria()
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(
                                              Icons.photo_library_outlined,
                                              size: 70,
                                            ),
                                            Text(
                                              "Escolher foto",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      readOnly: true,
                      validator: (value) {
                        atleta.imagemRegulamentoDoAtleta = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.image),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Foto regulamento',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          //abrirCamera();
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(
                                              Icons.camera_alt_outlined,
                                              size: 70,
                                            ),
                                            Text(
                                              "Tirar foto",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          //abrirGaleria()
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(
                                              Icons.photo_library_outlined,
                                              size: 70,
                                            ),
                                            Text(
                                              "Escolher foto",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      readOnly: true,
                      validator: (value) {
                        atleta.cpf = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.image),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Foto cpf',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          //abrirCamera();
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(
                                              Icons.camera_alt_outlined,
                                              size: 70,
                                            ),
                                            Text(
                                              "Tirar foto",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          //abrirGaleria()
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(
                                              Icons.photo_library_outlined,
                                              size: 70,
                                            ),
                                            Text(
                                              "Escolher foto",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      readOnly: true,
                      validator: (value) {
                        atleta.rg = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.image),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Foto rg',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          //abrirCamera();
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(
                                              Icons.camera_alt_outlined,
                                              size: 70,
                                            ),
                                            Text(
                                              "Tirar foto",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          //abrirGaleria()
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(
                                              Icons.photo_library_outlined,
                                              size: 70,
                                            ),
                                            Text(
                                              "Escolher foto",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: false,
                      readOnly: true,
                      validator: (value) {
                        atleta.imagemComprovanteDeResidencia = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.image),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Foto comprovante residência',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          //abrirCamera();
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(
                                              Icons.camera_alt_outlined,
                                              size: 70,
                                            ),
                                            Text(
                                              "Tirar foto",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          //abrirGaleria()
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(
                                              Icons.photo_library_outlined,
                                              size: 70,
                                            ),
                                            Text(
                                              "Escolher foto",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: BotaoAdicionar(
                            hintText: "Adicionar outro celular",
                            onTap: () {
                              if (camposAdicionais.length > 4) {
                                mostrarErro(
                                    context,
                                    'Limite de telefones atingidos',
                                    Colors.red);
                                return null;
                              }
                              adicionarCampo();
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: camposAdicionais,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void adicionarCampo() {
    setState(() {
      camposAdicionais.add(
        Card(
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: null,
                          items: telefones,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Este campo é obrigatório!";
                            }
                            atleta.sexo = value;
                            return null;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          onChanged: (String? value) {
                            valorSexo = value;
                          },
                          hint: const Text('Selecione uma opção'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.red, width: 2.0),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(2),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          foregroundColor: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {});
                        },
                        child: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    obscureText: false,
                    inputFormatters: [celualarFormatter],
                    validator: (value) {
                      atleta.alergiaAMedicamentos = value;
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: const OutlineInputBorder(),
                      labelText: 'Digite o número',
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> BuscarCep() async {
    String cep = txtCep.text;

    String url = "https://viacep.com.br/ws/$cep/json/";

    http.Response response;

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> dados = json.decode(response.body);

        String cidade = dados["localidade"];
        String bairro = dados["bairro"];
        String endereco = dados["logradouro"];
        String estado = dados["uf"];

        setState(() {
          atleta.cidade = cidade;
          atleta.bairro = bairro;
          atleta.endereco = endereco;
          atleta.estado = estado;

          cidadeController.text = cidade;
          bairroController.text = bairro;
          enderecoController.text = endereco;
          estadoController.text = estado;
        });
      } else {
        print("Erro na solicitação HTTP: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro durante a solicitação HTTP: $e");
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2024));
    if (picked != null) {
      setState(() {
        _dateController.text =
            DateFormat('dd/MM/yyyy', 'pt_BR').format(picked);
        atleta.dataDeNascimento =
            DateFormat('dd/MM/yyyy', 'pt_BR').format(picked);
      });
    }
  }
}
