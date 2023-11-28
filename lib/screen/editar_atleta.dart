import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/main.dart';
import 'package:desafio/model/atleta.dart';
import 'package:desafio/screen/menu_atleta.dart';
import 'package:desafio/widget/botao_loader.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:desafio/widget/drop_down_estados.dart';
import 'package:desafio/widget/icon_button.dart';
import 'package:desafio/widget/modal_imagem.dart';
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
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() async {
  runApp(MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('pt'),
    ],
    home: EditarAtleta(),
  ));
}

String? valorSexo;
String? valorEstado;
String? nomeCompleto;
String? email;
String? observacao;

int index = 0;
bool carregando = true;
bool fotoAtestado = false;
bool fotoAtleta = false;
bool fotoRegulamento = false;
bool fotoCpf = false;
bool fotoRg = false;
bool fotoComprovanteResidencia = false;
String? va;
FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;
String? collection;
String? documentId;

String? imagemAtestado;
String? imagemAtleta;
String? imagemRegulamentoDoAtleta;
String? imagemComprovanteDeResidencia;
String? imagemCpf;
String? imagemRg;

class EditarAtleta extends StatefulWidget {
  String? email;
  String? titulo;
  EditarAtleta({this.titulo, this.email, super.key});

  @override
  State<EditarAtleta> createState() => _EditarAtletaAppState();
}

TextEditingController cidadeController = TextEditingController();
TextEditingController bairroController = TextEditingController();
TextEditingController estadoController = TextEditingController();
TextEditingController enderecoController = TextEditingController();
TextEditingController _dateController = TextEditingController();

class _EditarAtletaAppState extends State<EditarAtleta> {
  @override
  void initState() {
    _carregarDados();
    super.initState();
  }

  Future<bool> _verificaTipo() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("Cadastro")
        .where("Email", isEqualTo: widget.email)
        .get();

    return querySnapshot.docs.isEmpty;
  }

  Future<void> _carregarDados() async {
    bool cadastrado = await _verificaTipo();
    setState(() {
      if (cadastrado) {
        collection = "VerificaCadastro";
      } else {
        collection = "Cadastro";
      }
    });

    await db
        .collection(collection!)
        .where("Email", isEqualTo: widget.email.toString())
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        setState(() {
          documentId = docSnapshot.id;
          observacao = docSnapshot.data()['Observacao'];
          atleta.nomeCompleto = docSnapshot.data()['NomeCompleto'];
          atleta.email = docSnapshot.data()['Email'];
          atleta.dataDeNascimento = docSnapshot.data()['DataNascimento'];
          _dateController.text = docSnapshot.data()['DataNascimento'];
          atleta.numeroDoCelular = docSnapshot.data()['NumeroCelular'];
          atleta.numeroDeEmergencia = docSnapshot.data()['NumeroEmergencia'];
          atleta.nacionalidade = docSnapshot.data()['Nacionalidade'];
          atleta.naturalidade = docSnapshot.data()['Naturalidade'];
          atleta.rg = docSnapshot.data()['Rg'];
          atleta.cpf = docSnapshot.data()['Cpf'];
          atleta.sexo = docSnapshot.data()['Sexo'];
          atleta.cep = docSnapshot.data()['Cep'];
          cidadeController.text = docSnapshot.data()['Cidade'];
          bairroController.text = docSnapshot.data()['Bairro'];
          enderecoController.text = docSnapshot.data()['Endereco'];
          atleta.numeroCasa = docSnapshot.data()['NumeroCasa'];
          estadoController.text = docSnapshot.data()['Estado'];
          atleta.convenioMedico = docSnapshot.data()['ConvenioMedico'];
          atleta.estilos = docSnapshot.data()['Estilos'];
          atleta.prova = docSnapshot.data()['Prova'];
          atleta.nomeDaMae = docSnapshot.data()['NomeMae'];
          atleta.nomeDoPai = docSnapshot.data()['NomePai'];
          atleta.clubeDeOrigem = docSnapshot.data()['ClubeOrigem'];
          atleta.localdetrabalho = docSnapshot.data()['LocalTrabalho'];
          atleta.alergiaAMedicamentos =
              docSnapshot.data()['AlergiaMedicamento'];
          atleta.numeroDeCelularAdicional =
              docSnapshot.data()['NumeroAdicional'];
          atleta.numeroDeCelularResidencial =
              docSnapshot.data()['NumeroResidencial'];
          atleta.numeroDeCelularAdicionalPai = docSnapshot.data()['NumeroPai'];
          atleta.numeroDeCelularAdicionalMae = docSnapshot.data()['NumeroMae'];
          _carregarImagens(documentId.toString());
        });
      }
    });
  }

  Future<void> _carregarImagens(String id) async {
    final storageRef = FirebaseStorage.instance.ref().child(id);
    final listResult = await storageRef.listAll();
    int valor = 0;
    Map<String, String> imagem = {};

    List<String> nomes = [
      "imagemAtestado",
      "imagemAtleta",
      "imagemRegulamentoDoAtleta",
      "imagemComprovanteDeResidencia",
      "imagemCpf",
      "imagemRg"
    ];

    for (var item in listResult.items) {
      imagem[nomes[valor]] = await item.getDownloadURL();
      valor++;
    }

    setState(() {
      imagemAtestado = imagem["imagemAtestado"];
      imagemAtleta = imagem["imagemAtleta"];
      imagemRegulamentoDoAtleta = imagem["imagemRegulamentoDoAtleta"];
      imagemComprovanteDeResidencia = imagem["imagemComprovanteDeResidencia"];
      imagemCpf = imagem["imagemCpf"];
      imagemRg = imagem["imagemRg"];
      fotoAtestado = true;
      fotoAtleta = true;
      fotoRegulamento = true;
      fotoCpf = true;
      fotoRg = true;
      fotoComprovanteResidencia = true;
      carregando = false;
    });
  }

  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem<String>(value: "Feminino", child: Text("Feminino")),
    const DropdownMenuItem<String>(
        value: "Masculino", child: Text("Masculino")),
    const DropdownMenuItem<String>(value: "Outro", child: Text("Outro")),
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

  var format = DateFormat('MM/dd/yyyy');
  final _formKey = GlobalKey<FormState>();

  List<Widget> camposAdicionais = [];

  TextEditingController txtCep = TextEditingController();

  Atleta atleta = Atleta(
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: carregando == true
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.black, size: 200))
          : SingleChildScrollView(
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
                            widget.titulo!,
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
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Visibility(
                              visible: observacao != null,
                              child: Text(
                                'Observacão do treinador: $observacao',
                                style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              keyboardType: TextInputType.datetime,
                              controller: _dateController,
                              validator: (value) {
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
                          TextFormFieldWithFormatter(
                            valorInicial: atleta.numeroDoCelular,
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
                            valorInicial: atleta.numeroDeEmergencia,
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
                            valorInicial: atleta.nacionalidade,
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
                            valorInicial: atleta.naturalidade,
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
                            valorInicial: atleta.cpf,
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
                            valorInicial: atleta.rg,
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
                            value: atleta.sexo!.isNotEmpty ? atleta.sexo : "",
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
                              valorSexo = value;
                            },
                            hint: const Text('Selecione uma opção'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWithFormatter(
                            valorInicial: atleta.cep,
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
                            valorInicial: atleta.numeroCasa,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo é obrigatório!";
                              }
                              atleta.numeroCasa = value;
                              return null;
                            },
                            labelText: 'Número da Casa',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldCadastro(
                            valorInicial: atleta.convenioMedico,
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
                            valorInicial: atleta.estilos,
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
                            valorInicial: atleta.prova,
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
                            valorInicial: atleta.nomeDaMae,
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
                            valorInicial: atleta.nomeDoPai,
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
                            valorInicial: atleta.clubeDeOrigem,
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
                            valorInicial: atleta.localdetrabalho,
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
                            valorInicial: atleta.alergiaAMedicamentos,
                            validator: (value) {
                              atleta.alergiaAMedicamentos = value;
                              return null;
                            },
                            labelText: 'Alergia a medicamentos',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldFoto(
                                  certo: fotoAtestado,
                                  hint: 'Foto atestado',
                              
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ModalImagem(
                                          onPhotoSelected: (fotoPath) {
                                            if (atleta.imagemAtestado != null) {
                                              atleta.imagemAtestado = fotoPath;
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
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              BotaoIcon(onTap: () {
                                _showImageFullScreen(imagemAtestado.toString());
                              }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldFoto(
                                  certo: fotoAtleta,
                                  hint: 'Foto atleta',
                                
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ModalImagem(
                                          onPhotoSelected: (fotoPath) {
                                            atleta.imagemAtleta = fotoPath;
                                            if (atleta.imagemAtleta != null) {
                                              setState(() {
                                                fotoAtleta = true;
                                              });
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              BotaoIcon(onTap: () {
                                _showImageFullScreen(imagemAtleta.toString());
                              }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldFoto(
                                  certo: fotoRegulamento,
                                  hint: 'Foto regulamento',
                                 
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ModalImagem(
                                          onPhotoSelected: (fotoPath) {
                                            atleta.imagemRegulamentoDoAtleta =
                                                fotoPath;
                                            if (atleta
                                                    .imagemRegulamentoDoAtleta !=
                                                null) {
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
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              BotaoIcon(onTap: () {
                                _showImageFullScreen(
                                    imagemRegulamentoDoAtleta.toString());
                              }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldFoto(
                                  certo: fotoCpf,
                                  hint: 'Foto cpf',
                                
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
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              BotaoIcon(onTap: () {
                                _showImageFullScreen(imagemCpf.toString());
                              }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldFoto(
                                  certo: fotoRg,
                                  hint: 'Foto rg',
                              
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
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              BotaoIcon(onTap: () {
                                _showImageFullScreen(imagemRg.toString());
                              }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldFoto(
                                  certo: fotoComprovanteResidencia,
                                  hint: 'Foto comprovante residência',
                               
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ModalImagem(
                                          onPhotoSelected: (fotoPath) {
                                            atleta.imagemComprovanteDeResidencia =
                                                fotoPath;
                                            if (atleta
                                                    .imagemComprovanteDeResidencia !=
                                                null) {
                                              setState(() {
                                                fotoComprovanteResidencia =
                                                    true;
                                              });
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              BotaoIcon(onTap: () {
                                _showImageFullScreen(
                                    imagemComprovanteDeResidencia.toString());
                              }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWithFormatter(
                            valorInicial: atleta.numeroDeCelularAdicional,
                            labelText: 'Celular adicional',
                            mask: '(##) # ####-####',
                            onChanged: (value) {},
                            validator: (value) {
                              atleta.numeroDeCelularAdicional = value;
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWithFormatter(
                            valorInicial: atleta.numeroDeCelularResidencial,
                            labelText: 'Celular residêncial',
                            mask: '(##) # ####-####',
                            onChanged: (value) {},
                            validator: (value) {
                              atleta.numeroDeCelularResidencial = value;
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWithFormatter(
                            valorInicial: atleta.numeroDeCelularLocalTrabalho,
                            labelText: 'Celular local trabalho',
                            mask: '(##) # ####-####',
                            onChanged: (value) {},
                            validator: (value) {
                              atleta.numeroDeCelularAdicional = value;
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWithFormatter(
                            valorInicial: atleta.numeroDeCelularAdicionalPai,
                            labelText: 'Celular pai',
                            mask: '(##) # ####-####',
                            onChanged: (value) {},
                            validator: (value) {
                              atleta.numeroDeCelularAdicionalPai = value;
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWithFormatter(
                            valorInicial: atleta.numeroDeCelularAdicionalMae,
                            labelText: 'Celular mãe',
                            mask: '(##) # ####-####',
                            onChanged: (value) {},
                            validator: (value) {
                              atleta.numeroDeCelularAdicionalMae = value;
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: collection == "VerificaCadastro",
                            child: BotaoLoader(
                              hintText: estaCarregando
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
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
                                        if (await VerificaCadastro() == false) {
                                          await UpdateAtleta(atleta, context);
                                          setState(() {
                                            estaCarregando = false;
                                          });
                                        } else {
                                          await FirebaseAuth.instance.signOut();
                                          setState(() {
                                            estaCarregando = false;
                                          });
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginApp()),
                                                  (route) => false);
                                        }
                                      }
                                    },
                            ),
                          ),
                          Visibility(
                            visible: collection == "Cadastro",
                            child: Column(
                              children: [
                                BotaoLoader(
                                  hintText: estaCarregando
                                      ? const CircularProgressIndicator(
                                          color: Colors.white)
                                      : Text(
                                          "Editar",
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              estaCarregando = true;
                                            });
                                            UpdateAtletaPerfil(atleta, context);
                                            setState(() {
                                              estaCarregando = false;
                                            });
                                          }
                                        },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                BotaoPrincipal(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    hintText: "Voltar",
                                    radius: 12,
                                    cor: Colors.amber),
                              ],
                            ),
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

  void _showImageFullScreen(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
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

UpdateAtleta(Atleta atleta, BuildContext context) async {
  Map<String, String> imageUrlMap = await saveImagesToStorage(atleta);

  final cadastroAtleta = <String, String>{
    "NomeCompleto": atleta.nomeCompleto.toString(),
    "Email": atleta.email.toString(),
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
    "NumeroCasa": atleta.numeroCasa.toString(),
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
    "Status": "Analise"
  };

  if (_auth.currentUser != null) {
    try {
      await db
          .collection("VerificaCadastro")
          .doc(_auth.currentUser!.uid)
          .update(cadastroAtleta)
          .onError((e, _) => print("Error writing document: $e"));

      if (atleta.imagemAtleta.toString().isNotEmpty) {
        await db.collection("Usuarios").doc(_auth.currentUser!.uid).update({
          "ImagemAtleta": imageUrlMap["imagemAtleta"],
        });
      }

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

UpdateAtletaPerfil(Atleta atleta, BuildContext context) async {
  Map<String, String> imageUrlMap = await saveImagesToStorage(atleta);

  final cadastroAtleta = <String, String>{
    "NomeCompleto": atleta.nomeCompleto.toString(),
    "Email": atleta.email.toString(),
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
    "NumeroCasa": atleta.numeroCasa.toString(),
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
  };

  if (_auth.currentUser != null) {
    try {
      await db
          .collection("Cadastro")
          .doc(documentId)
          .update(cadastroAtleta)
          .onError((e, _) => print("Error writing document: $e"));

      if (atleta.imagemAtleta.toString().isNotEmpty) {
        await db.collection("Usuarios").doc(documentId).update({
          "ImagemAtleta": imageUrlMap["imagemAtleta"],
        });
      }

      Navigator.pop(context);
    } catch (e) {
      print('Erro$e');
    }
  } else {
    print('Não Esta logado');
  }
}

Future<Map<String, String>> saveImagesToStorage(Atleta atleta) async {
  Map<String, String> imageUrlMap = {};

  if (atleta.imagemAtestado.toString().isNotEmpty) {
    SalvarImagem("imagemAtestado", atleta.imagemAtestado.toString());
  }

  if (atleta.imagemAtleta.toString().isNotEmpty) {
    final storageReference = FirebaseStorage.instance
        .ref()
        .child(documentId!)
        .child("imagemAtleta" + ".jpg");

    File imageFile = File(atleta.imagemAtleta.toString());

    await storageReference.putFile(imageFile);

    String imageUrl = await storageReference.getDownloadURL();

    imageUrlMap["imagemAtleta"] = imageUrl;
  }

  if (atleta.imagemRegulamentoDoAtleta.toString().isNotEmpty) {
    SalvarImagem("imagemRegulamentoDoAtleta",
        atleta.imagemRegulamentoDoAtleta.toString());
  }

  if (atleta.imagemComprovanteDeResidencia.toString().isNotEmpty) {
    SalvarImagem("imagemComprovanteDeResidencia",
        atleta.imagemComprovanteDeResidencia.toString());
  }

  if (atleta.imagemCpf.toString().isNotEmpty) {
    SalvarImagem("imagemCpf", atleta.imagemCpf.toString());
  }

  if (atleta.imagemRg.toString().isNotEmpty) {
    SalvarImagem("imagemRg", atleta.imagemRg.toString());
  }

  return imageUrlMap;
}

Future<void> SalvarImagem(String nome, String path) async {
  final storageReference =
      FirebaseStorage.instance.ref().child(documentId!).child(nome + ".jpg");

  File imageFile = File(path);

  await storageReference.putFile(imageFile);
}
