import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/main.dart';
import 'package:desafio/model/atleta.dart';
import 'package:desafio/screen/menu_atleta.dart';
import 'package:desafio/widget/botao_adicionar.dart';
import 'package:desafio/widget/botao_loader.dart';
import 'package:desafio/widget/drop_down_estados.dart';
import 'package:desafio/widget/modal_imagem.dart';
import 'package:desafio/widget/scaffolds.dart';
import 'package:desafio/widget/text_form_field_cadastro.dart';
import 'package:desafio/widget/text_form_field_foto.dart';
import 'package:desafio/widget/text_form_field_with_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

void main() async {
  runApp(const MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('pt'), // Defina o idioma e país desejados
    ],
    home: CadastroAtleta(),
  ));
}

String? valorSexo;
String? valorEstado;

int index = 0;

bool fotoAtestado = false;
bool fotoRegulamento = false;
bool fotoCpf = false;
bool fotoRg = false;
bool fotoComprovanteResidencia = false;
String? va;
FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;

bool estaCarregando = false;

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
        value: "Numero Adicional", child: Text("Número Adicional")),
    const DropdownMenuItem(
        value: "Numero Residencial", child: Text("Número Residencial")),
    const DropdownMenuItem(
        value: "Numero Local de Trabalho",
        child: Text("Número Local de Trabalho")),
    const DropdownMenuItem(value: "Numero Pai", child: Text("Número Pai")),
    const DropdownMenuItem(value: "Numero Mae", child: Text("Número Mãe")),
  ];

  final TextEditingController _dateController = TextEditingController();
  var format = DateFormat('MM/dd/yyyy');
  final _formKey = GlobalKey<FormState>();

  List<Widget> camposAdicionais = [];

  TextEditingController txtCep = TextEditingController();

  Atleta atleta = Atleta("", "", "", "", "", "", "", "", "", "", "", "", "", "",
      "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

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

                    TextFormField(
                        keyboardType: TextInputType.datetime,
                        controller: _dateController,
                        validator: (value) {
                          // if (value == null || value.isEmpty) {
                          //   return "Este campo é obrigatório!";
                          // }
                          atleta.dataDeNascimento = value;
                          return null;
                        },
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
                        atleta.localdetrabalho = value;
                        return null;
                      },
                      labelText: 'Local de trabalho',
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    TextFormFieldCadastro(
                      validator: (value) {
                        atleta.alergiaAMedicamentos = value;
                        return null;
                      },
                      labelText: 'Alergia a medicamentos',
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldFoto(
                      certo: fotoAtestado,
                      hint: 'Foto atestado',
                      validator: (value) {
                        if (fotoAtestado == false) {
                          return "Este campo é obrigatório!";
                        }
                        return null;
                      },
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return ModalImagem(
                              onPhotoSelected: (fotoPath) {
                                atleta.imagemAtestado = fotoPath;
                                if (atleta.imagemAtestado != null) {
                                  setState(() {
                                    fotoAtestado = true;
                                  });
                                }
                              },
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldFoto(
                      certo: fotoRegulamento,
                      hint: 'Foto regulamento',
                      validator: (value) {
                        if (fotoRegulamento == false) {
                          return "Este campo é obrigatório!";
                        }
                        return null;
                      },
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return ModalImagem(
                              onPhotoSelected: (fotoPath) {
                                atleta.imagemRegulamentoDoAtleta = fotoPath;
                                if (atleta.imagemRegulamentoDoAtleta != null) {
                                  setState(() {
                                    fotoRegulamento = true;
                                  });
                                }
                              },
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldFoto(
                      certo: fotoCpf,
                      hint: 'Foto cpf',
                      validator: (value) {
                        if (fotoCpf == false) {
                          return "Este campo é obrigatório!";
                        }
                        return null;
                      },
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return ModalImagem(
                              onPhotoSelected: (fotoPath) {
                                atleta.imagemCpf = fotoPath;
                                if (atleta.imagemCpf != null) {
                                  setState(() {
                                    fotoCpf = true;
                                  });
                                }
                              },
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldFoto(
                      certo: fotoRg,
                      hint: 'Foto rg',
                      validator: (value) {
                        if (fotoRg == false) {
                          return "Este campo é obrigatório!";
                        }
                        return null;
                      },
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return ModalImagem(
                              onPhotoSelected: (fotoPath) {
                                atleta.imagemRg = fotoPath;
                                if (atleta.imagemRg != null) {
                                  setState(() {
                                    fotoRg = true;
                                  });
                                }
                              },
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormFieldFoto(
                      certo: fotoComprovanteResidencia,
                      hint: 'Foto comprovante residência',
                      validator: (value) {
                        if (fotoComprovanteResidencia == false) {
                          return "Este campo é obrigatório!";
                        }
                        return null;
                      },
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return ModalImagem(
                              onPhotoSelected: (fotoPath) {
                                atleta.imagemComprovanteDeResidencia = fotoPath;
                                if (atleta.imagemComprovanteDeResidencia !=
                                    null) {
                                  setState(() {
                                    fotoComprovanteResidencia = true;
                                  });
                                }
                              },
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
                            cor: Colors.green,
                            hintText: "Adicionar outro celular",
                            onTap: () {
                              if (camposAdicionais.length > 4) {
                                Mensagem(
                                    context,
                                    'Limite de telefones atingidos',
                                    Colors.red);
                                return null;
                              }
                              adicionarCampo();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Visibility(
                          visible: camposAdicionais.isNotEmpty,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () {
                                camposAdicionais.removeLast();
                                setState(() {
                                  camposAdicionais;
                                });
                              },
                              child: const Text('Apagar ultimo número')),
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
                    BotaoLoader(
                      hintText: estaCarregando
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Enviar",
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                      cor: Colors.blueAccent,
                      onTap: estaCarregando
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  estaCarregando = true;
                                });
                                if (await VerificaCadastro(context) == false) {
                                  await CadastrarAtleta(atleta, context);
                                  setState(() {
                                    estaCarregando = false;
                                  });
                                } else {
                                  await FirebaseAuth.instance.signOut();
                                  setState(() {
                                    estaCarregando = false;
                                  });
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginApp()),
                                      (route) => false);
                                }
                              }
                            },
                    ),

                    const SizedBox(
                      height: 30,
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
            side: const BorderSide(color: Colors.black, width: 1),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            setState(() {
                              va = value;
                            });
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
                            if (value != null) {
                              setState(() {
                                telefones = telefones
                                    .where((item) => item.value != value)
                                    .toList();
                              });
                            }
                          },
                          hint: const Text('Selecione uma opção'),
                        ),
                      ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     side: const BorderSide(color: Colors.red, width: 2.0),
                      //     shape: const CircleBorder(),
                      //     padding: const EdgeInsets.all(2),
                      //     backgroundColor:
                      //         const Color.fromARGB(255, 255, 255, 255),
                      //     foregroundColor: Colors.red,
                      //   ),
                      //   onPressed: () {},
                      //   child: IconButton(
                      //     icon: const Icon(Ionicons.trash_outline),
                      //     onPressed: () {},
                      //   ),
                      // ),
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
                      switch (va) {
                        case "Numero Adicional":
                          atleta.numeroDeCelularAdicional = value;
                          break;
                        case "Numero Residencial":
                          atleta.numeroDeCelularResidencial = value;
                          break;
                        case "Numero Local de Trabalho":
                          atleta.numeroDeCelularLocalTrabalho = value;
                          break;
                        case "Numero Pai":
                          atleta.numeroDeCelularAdicionalPai = value;
                          break;
                        case "Numero Mae":
                          atleta.numeroDeCelularAdicionalMae = value;
                          break;
                        default:
                          print('Erro');
                      }
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
        _dateController.text = DateFormat(
          'dd/MM/yyyy',
        ).format(picked);
        atleta.dataDeNascimento = DateFormat(
          'dd/MM/yyyy',
        ).format(picked);
      });
    }
  }
}

CadastrarAtleta(Atleta atleta, BuildContext context) async {
  List<String> listaImages = [
    atleta.imagemAtestado.toString(),
    atleta.imagemRegulamentoDoAtleta.toString(),
    atleta.imagemComprovanteDeResidencia.toString(),
    atleta.imagemCpf.toString(),
    atleta.imagemRg.toString()
  ];

  Map<String, String> imageUrlMap = await saveImagesToStorage(listaImages);

  final cadastroAtleta = <String, String>{
    "Email": _auth.currentUser!.email.toString(),
    "DataNascimento": atleta.dataDeNascimento.toString(),
    "NumeroCelular": atleta.numeroDoCelular.toString(),
    "NumeroEmergencia": atleta.numeroDeEmergencia.toString(),
    "Nacionalidade": atleta.nacionalidade.toString(),
    "Naturalidade": atleta.naturalidade.toString(),
    "Rg": atleta.rg.toString(),
    "Cpf": atleta.cpf.toString(),
    "Sexo": atleta.sexo.toString(),
    "Cep": atleta.cep.toString(),
    "Cidade": atleta.cidade.toString(),
    "Bairro": atleta.bairro.toString(),
    "Endereco": atleta.endereco.toString(),
    "Estado": atleta.estado.toString(),
    "ConvenioMedico": atleta.convenioMedico.toString(),
    "Estilos": atleta.estilos.toString(),
    "Prova": atleta.prova.toString(),
    "NomeMae": atleta.nomeDaMae.toString(),
    "NomePai": atleta.nomeDoPai.toString(),
    "ClubeOrigem": atleta.clubeDeOrigem.toString(),
    "AlergiaMedicamento": atleta.alergiaAMedicamentos.toString(),
    "NumeroAdicional": atleta.numeroDeCelularAdicional.toString(),
    "NumeroResidencial": atleta.numeroDeCelularResidencial.toString(),
    "NumeroPai": atleta.numeroDeCelularAdicionalPai.toString(),
    "NumeroMae": atleta.numeroDeCelularAdicionalMae.toString(),
    "ImagemAtestado": imageUrlMap["imagemAtestado"].toString(),
    "ImagemRegulamento": imageUrlMap["imagemRegulamentoDoAtleta"].toString(),
    "ImagemComprovanteResidencia":
        imageUrlMap["imagemComprovanteDeResidencia"].toString(),
    "ImagemCpf": imageUrlMap["imagemCpf"].toString(),
    "ImagemRg": imageUrlMap["imagemRg"].toString(),
  };

  if (_auth.currentUser != null) {
    try {
      await db
          .collection("Cadastro")
          .doc(_auth.currentUser!.uid)
          .set(cadastroAtleta)
          .onError((e, _) => print("Error writing document: $e"));

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MenuAtletaApp()),
          (route) => false);
    } catch (e) {
      print('Erro$e');
    }
  } else {
    print('Não Esta logado');
  }
}

Future<Map<String, String>> saveImagesToStorage(
    List<String> listaImagen) async {
  Map<String, String> imageUrlMap = {};
  var valor = 0;

  for (String imagePath in listaImagen) {
    List<String> nomes = [
      "imagemAtestado",
      "imagemRegulamentoDoAtleta",
      "imagemComprovanteDeResidencia",
      "imagemCpf",
      "imagemRg"
    ];

    final Reference storageReference =
        FirebaseStorage.instance.ref().child("images/${const Uuid().v4()}.jpg");

    File imageFile = File(imagePath);

    UploadTask uploadTask = storageReference.putFile(imageFile);

    await uploadTask.whenComplete(() => null);

    String imageUrl = await storageReference.getDownloadURL();

    String imageName = nomes[valor].split('/').last;

    imageUrlMap[imageName] = imageUrl;
    valor++;
  }
  return imageUrlMap;
}
