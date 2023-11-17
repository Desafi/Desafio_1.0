import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/model/atleta.dart';
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

  const TelaExpandidaAtletaApp({
    super.key,
    required this.emailUser,
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
    "");

class _TelaExpandidaAtletaAppState extends State<TelaExpandidaAtletaApp> {
  Future<void> _carregarDados(String email) async {
    await db
        .collection("Cadastro")
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

          // atleta.imagemAtestado = docSnapshot.data()['ImagemAtestado'];
          // atleta.imagemAtleta = docSnapshot.data()['ImagemAtleta'];
          // atleta.imagemRegulamentoDoAtleta =
          //     docSnapshot.data()['ImagemRegulamento'];
          // atleta.imagemComprovanteDeResidencia =
          //     docSnapshot.data()['ImagemComprovanteResidencia'];
          // atleta.imagemCpf = docSnapshot.data()['ImagemCpf'];
          // atleta.imagemRg = docSnapshot.data()['ImagemRg'];
          // carregando = false;
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
      atleta.imagemComprovanteDeResidencia = imagem["imagemComprovanteDeResidencia"];
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
                    SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Data de Nascimento",
                        valor: atleta.dataDeNascimento.toString()),
                    SizedBox(height: 10),
                    InputMostrar(
                      hintText: "Número de Celular",
                      valor: atleta.numeroDoCelular.toString(),
                    ),
                    SizedBox(height: 10),
                    InputMostrar(
                      hintText: "Número de Emergência",
                      valor: atleta.numeroDeEmergencia.toString(),
                    ),
                    SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Nacionalidade",
                        valor: atleta.nacionalidade.toString()),
                    SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Naturalidade",
                        valor: atleta.naturalidade.toString()),
                    SizedBox(height: 10),
                    InputMostrar(hintText: "RG", valor: atleta.rg.toString()),
                    SizedBox(height: 10),
                    InputMostrar(hintText: "CPF", valor: atleta.cpf.toString()),
                    SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Sexo", valor: atleta.sexo.toString()),
                    SizedBox(height: 10),
                    InputMostrar(hintText: "CEP", valor: atleta.cep.toString()),
                    SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Bairro", valor: atleta.bairro.toString()),
                    SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Endereço",
                        valor: atleta.endereco.toString()),
                    SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Convênio médico",
                        valor: atleta.convenioMedico.toString()),
                    SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Estilos", valor: atleta.estilos.toString()),
                    SizedBox(height: 10),
                    InputMostrar(
                        hintText: "Prova", valor: atleta.prova.toString()),
                    SizedBox(height: 10),
                    InputMostrarFoto(
                      hintText: "Imagem Atestado",
                      showImageFunction: _showImageFullScreen,
                      linkImagem: atleta.imagemAtestado.toString(),
                    ),
                    SizedBox(height: 10),
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
                          SizedBox(height: 10),
                          InputMostrar(
                              hintText: "Nome da Mãe",
                              valor: atleta.nomeDaMae.toString()),
                          SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Nome do Pai",
                            valor: atleta.nomeDoPai.toString(),
                          ),
                          SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Clube de Origem",
                            valor: atleta.clubeDeOrigem.toString(),
                          ),
                          SizedBox(height: 10),
                          InputMostrar(
                              hintText: "Alergia a Medicamentos",
                              valor: atleta.alergiaAMedicamentos.toString()),
                          SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Número de celular adicional",
                            valor: atleta.numeroDeCelularAdicional.toString(),
                          ),
                          SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Número de celular mãe",
                            valor:
                                atleta.numeroDeCelularAdicionalMae.toString(),
                          ),
                          SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Número de celular pai",
                            valor:
                                atleta.numeroDeCelularAdicionalPai.toString(),
                          ),
                          SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Número de celular trabalho",
                            valor:
                                atleta.numeroDeCelularLocalTrabalho.toString(),
                          ),
                          SizedBox(height: 10),
                          InputMostrar(
                            hintText: "Número de celular residencial",
                            valor: atleta.numeroDeCelularResidencial.toString(),
                          ),
                        ],
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
