import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/model/atleta.dart';
import 'package:desafio/screen/editar_atleta.dart';
import 'package:desafio/screen/gerenciamento_atletas.dart';
import 'package:desafio/widget/botao_principal.dart';
import 'package:desafio/widget/input_mostrar.dart';
import 'package:desafio/widget/input_mostrar_foto.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: TelaExpandidaAtletaApp(),
//     );
//   }
// }

class TelaExpandidaAtletaApp extends StatefulWidget {
  final String emailUser;
  final String tabela;
  final bool botoes;

  const TelaExpandidaAtletaApp({
    super.key,
    required this.emailUser,
    required this.tabela,
    required this.botoes,
  });

  @override
  State<TelaExpandidaAtletaApp> createState() => _TelaExpandidaAtletaAppState();
}

bool carregando = true;
String? documentId;
FirebaseFirestore db = FirebaseFirestore.instance;
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

class _TelaExpandidaAtletaAppState extends State<TelaExpandidaAtletaApp> {
  TextEditingController observacaoController = TextEditingController();

  Future<void> _carregarDados(String email) async {
    await db
        .collection(widget.tabela)
        .where("Email", isEqualTo: email)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        setState(() {
          documentId = docSnapshot.id;
          atleta.nomeCompleto = docSnapshot.data()['NomeCompleto'];
          atleta.email = docSnapshot.data()['Email'];
          atleta.dataDeNascimento = docSnapshot.data()['DataNascimento'];
          atleta.numeroDoCelular = docSnapshot.data()['NumeroCelular'];
          atleta.numeroDeEmergencia = docSnapshot.data()['NumeroEmergencia'];
          atleta.nacionalidade = docSnapshot.data()['Nacionalidade'];
          atleta.naturalidade = docSnapshot.data()['Naturalidade'];
          atleta.rg = docSnapshot.data()['Rg'];
          atleta.cpf = docSnapshot.data()['Cpf'];
          atleta.sexo = docSnapshot.data()['Sexo'];
          atleta.cep = docSnapshot.data()['Cep'];
          atleta.cidade = docSnapshot.data()['Cidade'];
          atleta.bairro = docSnapshot.data()['Bairro'];
          atleta.endereco = docSnapshot.data()['Endereco'];
          atleta.numeroCasa = docSnapshot.data()['NumeroCasa'];
          atleta.estado = docSnapshot.data()['Estado'];
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
      atleta.imagemAtestado = imagem["imagemAtestado"];
      atleta.imagemAtleta = imagem["imagemAtleta"];
      atleta.imagemRegulamentoDoAtleta = imagem["imagemRegulamentoDoAtleta"];
      atleta.imagemComprovanteDeResidencia =
          imagem["imagemComprovanteDeResidencia"];
      atleta.imagemCpf = imagem["imagemCpf"];
      atleta.imagemRg = imagem["imagemRg"];
      carregando = false;
    });
  }

  @override
  void initState() {
    _carregarDados(widget.emailUser);
    super.initState();
  }

  bool _showMoreInfo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text("Informações do Atleta"),
      ),
      body: carregando == true
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.black, size: 200))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 90,
                        backgroundImage:
                            NetworkImage(atleta.imagemAtleta.toString()),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InputMostrar(
                      hintText: "Nome Completo",
                      valor: atleta.nomeCompleto.toString(),
                    ),
                    const SizedBox(height: 10),
                    InputMostrar(
                        hintText: "E-mail", valor: atleta.email.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Data de Nascimento",
                        valor: atleta.dataDeNascimento.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(
                      hintText: "Número de Celular",
                      valor: atleta.numeroDoCelular.toString(),
                    ),
                    const SizedBox(height: 10),
                    InputMostrar(
                      hintText: "Número de Emergência",
                      valor: atleta.numeroDeEmergencia.toString(),
                    ),
                    const SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Nacionalidade",
                        valor: atleta.nacionalidade.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Naturalidade",
                        valor: atleta.naturalidade.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(hintText: "RG", valor: atleta.rg.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(hintText: "CPF", valor: atleta.cpf.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Sexo", valor: atleta.sexo.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(hintText: "CEP", valor: atleta.cep.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Bairro", valor: atleta.bairro.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Endereço",
                        valor: atleta.endereco.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Numero Casa",
                        valor: atleta.numeroCasa.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Convênio médico",
                        valor: atleta.convenioMedico.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Estilos", valor: atleta.estilos.toString()),
                    const SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Prova", valor: atleta.prova.toString()),
                    const SizedBox(height: 10),
                    InputMostrarFoto(
                      hintText: "Imagem Atestado",
                      showImageFunction: _showImageFullScreen,
                      linkImagem: atleta.imagemAtestado.toString(),
                    ),
                    const SizedBox(height: 10),
                    InputMostrarFoto(
                      hintText: "Imagem RG",
                      showImageFunction: _showImageFullScreen,
                      linkImagem: atleta.imagemRg.toString(),
                    ),
                    const SizedBox(height: 10),
                    InputMostrarFoto(
                      hintText: "Imagem CPF",
                      showImageFunction: _showImageFullScreen,
                      linkImagem: atleta.imagemCpf.toString(),
                    ),
                    const SizedBox(height: 10),
                    InputMostrarFoto(
                      hintText: "Imagem Comprovante de Residência",
                      showImageFunction: _showImageFullScreen,
                      linkImagem:
                          atleta.imagemComprovanteDeResidencia.toString(),
                    ),
                    const SizedBox(height: 10),
                    InputMostrarFoto(
                      hintText: "Imagem Regulamento do Atleta",
                      showImageFunction: _showImageFullScreen,
                      linkImagem: atleta.imagemRegulamentoDoAtleta.toString(),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showMoreInfo = !_showMoreInfo;
                        });
                      },
                      child: Text(_showMoreInfo
                          ? "Ocultar Informações"
                          : "Exibir Mais Informações"),
                    ),
                    if (_showMoreInfo)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          InputMostrar(
                              hintText: "Nome da Mãe",
                              valor: atleta.nomeDaMae.toString()),
                          const SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Nome do Pai",
                            valor: atleta.nomeDoPai.toString(),
                          ),
                          const SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Clube de Origem",
                            valor: atleta.clubeDeOrigem.toString(),
                          ),
                          const SizedBox(height: 10),
                          InputMostrar(
                              hintText: "Alergia a Medicamentos",
                              valor: atleta.alergiaAMedicamentos.toString()),
                          const SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Número de celular adicional",
                            valor: atleta.numeroDeCelularAdicional.toString(),
                          ),
                          const SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Número de celular mãe",
                            valor:
                                atleta.numeroDeCelularAdicionalMae.toString(),
                          ),
                          const SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Número de celular pai",
                            valor:
                                atleta.numeroDeCelularAdicionalPai.toString(),
                          ),
                          const SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Número de celular trabalho",
                            valor:
                                atleta.numeroDeCelularLocalTrabalho.toString(),
                          ),
                          const SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Número de celular residencial",
                            valor: atleta.numeroDeCelularResidencial.toString(),
                          ),
                        ],
                      ),
                    Visibility(
                        visible: widget.botoes,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            BotaoPrincipal(
                              radius: 12,
                              hintText: "Aceitar",
                              cor: Colors.blueAccent,
                              onTap: () async {
                                final cadastroAtleta = <String, String>{
                                  "NomeCompleto":
                                      atleta.nomeCompleto.toString(),
                                  "Email": atleta.email.toString(),
                                  "DataNascimento":
                                      atleta.dataDeNascimento.toString(),
                                  "NumeroCelular":
                                      atleta.numeroDoCelular.toString(),
                                  "NumeroEmergencia":
                                      atleta.numeroDeEmergencia.toString(),
                                  "Nacionalidade":
                                      atleta.nacionalidade.toString(),
                                  "Naturalidade":
                                      atleta.naturalidade.toString(),
                                  "Rg": atleta.rg.toString(),
                                  "Cpf": atleta.cpf.toString(),
                                  "Sexo": atleta.sexo.toString(),
                                  "Cep": atleta.cep.toString(),
                                  "Cidade": atleta.cidade.toString(),
                                  "Bairro": atleta.bairro.toString(),
                                  "Endereco": atleta.endereco.toString(),
                                  "NumeroCasa": atleta.numeroCasa.toString(),
                                  "Estado": atleta.estado.toString(),
                                  "ConvenioMedico":
                                      atleta.convenioMedico.toString(),
                                  "Estilos": atleta.estilos.toString(),
                                  "Prova": atleta.prova.toString(),
                                  "NomeMae": atleta.nomeDaMae.toString(),
                                  "NomePai": atleta.nomeDoPai.toString(),
                                  "ClubeOrigem":
                                      atleta.clubeDeOrigem.toString(),
                                  "AlergiaMedicamento":
                                      atleta.alergiaAMedicamentos.toString(),
                                  "NumeroAdicional": atleta
                                      .numeroDeCelularAdicional
                                      .toString(),
                                  "NumeroResidencial": atleta
                                      .numeroDeCelularResidencial
                                      .toString(),
                                  "NumeroPai": atleta
                                      .numeroDeCelularAdicionalPai
                                      .toString(),
                                  "NumeroMae": atleta
                                      .numeroDeCelularAdicionalMae
                                      .toString(),
                                };

                                try {
                                  await db
                                      .collection("Cadastro")
                                      .doc(documentId)
                                      .set(cadastroAtleta)
                                      .onError((e, _) =>
                                          print("Error writing document: $e"));

                                  await db
                                      .collection("Usuarios")
                                      .doc(documentId)
                                      .update({"Status": "Aprovado"});

                                  await db
                                      .collection("VerificaCadastro")
                                      .doc(documentId)
                                      .delete();

                                  Navigator.pop(context);
                                } catch (e) {
                                  print('Erro$e');
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            BotaoPrincipal(
                              radius: 12,
                              hintText: "Recusar",
                              cor: Colors.amber,
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: SizedBox(
                                        height: 500,
                                        child: Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const SizedBox(height: 20),
                                              const Text(
                                                'Envie uma mensagem dizendo o que está errado:',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              const SizedBox(height: 20),
                                              TextField(
                                                controller:
                                                    observacaoController,
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              const SizedBox(height: 30),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  BotaoPrincipal(
                                                    radius: 12,
                                                    hintText: "Cancelar",
                                                    cor: Colors.amber,
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  BotaoPrincipal(
                                                    radius: 12,
                                                    hintText: "Enviar",
                                                    cor: Colors.blueAccent,
                                                    onTap: () async {
                                                      await db
                                                          .collection(
                                                              "VerificaCadastro")
                                                          .doc(documentId)
                                                          .update({
                                                        "Observacao":
                                                            observacaoController
                                                                .text
                                                                .toString(),
                                                        "Status": "Recusado"
                                                      });
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const GerenciamentoAtletasApp()),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        )),
                    Visibility(
                      visible: !widget.botoes,
                      child: Column(
                        children: [
                          BotaoPrincipal(
                              onTap: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => EditarAtleta(
                                            titulo: "Editar",
                                            email: widget.emailUser,
                                          )),
                                );
                              },
                              hintText: "Editar atleta",
                              radius: 12,
                              cor: Colors.blueAccent)
                        ],
                      ),
                    ),
                  ],
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
}
