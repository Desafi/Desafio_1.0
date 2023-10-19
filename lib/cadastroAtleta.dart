import 'package:desafio/model/atleta.dart';
import 'package:desafio/widget/BotaoAdicionar.dart';
import 'package:desafio/widget/BotaoPrincipal.dart';
import 'package:desafio/widget/DropDownEstados.dart';
import 'package:desafio/widget/ModalImagem.dart';
import 'package:desafio/widget/Scaffolds.dart';
import 'package:desafio/widget/TextFormFieldCadastro.dart';
import 'package:desafio/widget/TextFormFieldFoto.dart';
import 'package:desafio/widget/TextFormFieldWithFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

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
String? variavelModel;

class CadastroAtleta extends StatefulWidget {
  const CadastroAtleta({super.key});

  @override
  State<CadastroAtleta> createState() => _CadastroAtletaAppState();
}

class _CadastroAtletaAppState extends State<CadastroAtleta> {
  TextEditingController cidadeController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();

  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "Feminino", child: Text("Feminino")),
    const DropdownMenuItem(value: "Masculino", child: Text("Masculino")),
    const DropdownMenuItem(value: "Outro", child: Text("Outro")),
  ];

  List<DropdownMenuItem<String>> telefones = [
    const DropdownMenuItem(
        value: "atleta.numeroDeCelularAdicional",
        child: Text("Numero Adicional")),
    const DropdownMenuItem(
        value: "atleta.numeroDeCelularResidencial",
        child: Text("Numero Residencial")),
    const DropdownMenuItem(
        value: "atleta.numeroDeCelularLocalTrabalho",
        child: Text("Número Local de Trabalho")),
    const DropdownMenuItem(
        value: "atleta.numeroDeCelularAdicionalPai", child: Text("Número Pai")),
    const DropdownMenuItem(
        value: "atleta.numeroDeCelularAdicionalMae", child: Text("Número Mae")),
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
                    // mask: '(##) # ####-####',
                    //     filter: {"#": RegExp(r'[0-9]')},
                    TextFormFieldWithFormatter(
                      labelText: 'Celular',
                      mask: '(##) # ####-####',
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }

                        atleta.numeroDoCelular = value;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormFieldWithFormatter(
                      labelText: 'Celular de emergência',
                      mask: '(##) # ####-####',
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.numeroDeEmergencia = value;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormFieldCadastro(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.nacionalidade = value;
                        return null;
                      },
                      labelText: 'Nacionalidade',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormFieldCadastro(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.naturalidade = value;
                        return null;
                      },
                      labelText: 'Naturalidade',
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldWithFormatter(
                      labelText: 'Cpf',
                      mask: '###.###.###-##',
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.cpf = value;
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldWithFormatter(
                      labelText: 'Rg',
                      mask: '##.###.###-#',
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.rg = value;
                        return null;
                      },
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

                    TextFormFieldWithFormatter(
                      labelText: 'Cep',
                      mask: '#####-###',
                      onChanged: (value) {
                        if (value.length == 9) {
                          BuscarCep(value);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.cep = value;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormFieldCadastro(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo é obrigatório!";
                              }
                              atleta.cidade = value;
                              return null;
                            },
                            labelText: 'Cidade',
                            formController: cidadeController,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: DropDownEstados(
                            formController: estadoController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == "UF") {
                                return "Este campo é obrigatório!";
                              }
                              atleta.estado = value;
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormFieldCadastro(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.bairro = value;
                        return null;
                      },
                      labelText: 'Bairro',
                      formController: bairroController,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    TextFormFieldCadastro(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.endereco = value;
                        return null;
                      },
                      labelText: 'Endereço',
                      formController: enderecoController,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldCadastro(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.convenioMedico = value;
                        return null;
                      },
                      labelText: 'Convênio Médico',
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    TextFormFieldCadastro(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.estilos = value;
                        return null;
                      },
                      labelText: 'Estilo natação',
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldCadastro(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.prova = value;
                        return null;
                      },
                      labelText: 'Prova atleta',
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    TextFormFieldCadastro(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.nomeDaMae = value;
                        return null;
                      },
                      labelText: 'Nome da mãe',
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldCadastro(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.nomeDoPai = value;
                        return null;
                      },
                      labelText: 'Nome do pai',
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldCadastro(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.clubeDeOrigem = value;
                        return null;
                      },
                      labelText: 'Clube de origem',
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    TextFormFieldCadastro(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        atleta.alergiaAMedicamentos = value;
                        return null;
                      },
                      labelText: 'Alergia a medicamentos',
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldFoto(
                      hint: 'Foto atestado',
                      validator: (value) {
                        atleta.imagemAtestado = value;
                        return null;
                      },
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return const ModalImagem();
                          },
                        );
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    TextFormFieldFoto(
                      hint: 'Foto regulamento',
                      validator: (value) {
                        atleta.imagemRegulamentoDoAtleta = value;
                        return null;
                      },
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return const ModalImagem();
                          },
                        );
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldFoto(
                      hint: 'Foto cpf',
                      validator: (value) {
                        atleta.cpf = value;
                        return null;
                      },
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return const ModalImagem();
                          },
                        );
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldFoto(
                      hint: 'Foto rg',
                      validator: (value) {
                        atleta.rg = value;
                        return null;
                      },
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return const ModalImagem();
                          },
                        );
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldFoto(
                      hint: 'Foto comprovante residência',
                      validator: (value) {
                        atleta.imagemComprovanteDeResidencia = value;
                        return null;
                      },
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return const ModalImagem();
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
                            cor: Colors.green,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: camposAdicionais,
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    BotaoPrincipal(
                      hintText: 'Enviar',
                      cor: Colors.blue,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {}
                      },
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
          color: Colors.grey[100],
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black, width: 1),
          ),
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
                            variavelModel = value;
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
                          onChanged: (String? value) {},
                          hint: const Text('Selecione uma opção'),
                        ),
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
                          icon: const Icon(Ionicons.trash_outline),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  TextFormFieldWithFormatter(
                    labelText: 'Celular',
                    mask: '(##) # ####-####',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Este campo é obrigatório!";
                      }
                      variavelModel = value;
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> BuscarCep(String cep) async {
    String url = "https://viacep.com.br/ws/$cep/json/";

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
        _dateController.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(picked);
        atleta.dataDeNascimento =
            DateFormat('dd/MM/yyyy', 'pt_BR').format(picked);
      });
    }
  }
}
