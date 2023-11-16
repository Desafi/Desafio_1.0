import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/model/atleta.dart';
import 'package:desafio/widget/input_mostrar.dart';
import 'package:desafio/widget/input_mostrar_foto.dart';
import 'package:flutter/material.dart';

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

FirebaseFirestore db = FirebaseFirestore.instance;
Atleta atleta = Atleta("", "", "", "", "", "", "", "", "", "", "", "", "", "",
    "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

class _TelaExpandidaAtletaAppState extends State<TelaExpandidaAtletaApp> {
  @override
  void initState() {
    db
        .collection("Cadastro")
        .where("Email", isEqualTo: widget.emailUser)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
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
        atleta.alergiaAMedicamentos = docSnapshot.data()['AlergiaMedicamento'];
        atleta.numeroDeCelularAdicional = docSnapshot.data()['NumeroAdicional'];
        atleta.numeroDeCelularResidencial =
            docSnapshot.data()['NumeroResidencial'];
        atleta.numeroDeCelularAdicionalPai = docSnapshot.data()['NumeroPai'];
        atleta.numeroDeCelularAdicionalMae = docSnapshot.data()['NumeroMae'];
        atleta.imagemAtestado = docSnapshot.data()['ImagemAtestado'];
        atleta.imagemRegulamentoDoAtleta =
            docSnapshot.data()['ImagemRegulamento'];
        atleta.imagemComprovanteDeResidencia =
            docSnapshot.data()['ImagemComprovanteResidencia'];
        atleta.imagemCpf = docSnapshot.data()['ImagemCpf'];
        atleta.imagemRg = docSnapshot.data()['ImagemRg'];
      }
    });
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/person.jpg'),
                ),
              ),
              const SizedBox(height: 20),
              InputMostrar(
                hintText: "Nome Completo",
                valor: atleta.nomeCompleto.toString(),
              ),
              const SizedBox(height: 10),
              InputMostrar(hintText: "E-mail", valor: atleta.email.toString()),
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
              InputMostrar(hintText: "Sexo", valor: atleta.sexo.toString()),
              SizedBox(height: 10),
              InputMostrar(hintText: "CEP", valor: atleta.cep.toString()),
              SizedBox(height: 10),
              InputMostrar(hintText: "Bairro", valor: atleta.bairro.toString()),
              SizedBox(height: 10),
              InputMostrar(
                  hintText: "Endereço", valor: atleta.endereco.toString()),
              SizedBox(height: 10),
              InputMostrar(
                  hintText: "Convênio médico",
                  valor: atleta.convenioMedico.toString()),
              SizedBox(height: 10),
              InputMostrar(
                  hintText: "Estilos", valor: atleta.estilos.toString()),
              SizedBox(height: 10),
              InputMostrar(hintText: "Prova", valor: atleta.prova.toString()),
              SizedBox(height: 10),
              InputMostrarFoto(
                  hintText: "Imagem Atestado",
                  showImageFunction: _showImageFullScreen),
              SizedBox(height: 10),
              InputMostrarFoto(
                  hintText: "Imagem RG",
                  showImageFunction: _showImageFullScreen),
              const SizedBox(height: 10),
              InputMostrarFoto(
                  hintText: "Imagem CPF",
                  showImageFunction: _showImageFullScreen),
              const SizedBox(height: 10),
              InputMostrarFoto(
                  hintText: "Imagem Comprovante de Residência",
                  showImageFunction: _showImageFullScreen),
              const SizedBox(height: 10),
              InputMostrarFoto(
                  hintText: "Imagem Regulamento do Atleta",
                  showImageFunction: _showImageFullScreen),
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
                      hintText: "Número de celular adicional",
                      valor: atleta.numeroDeCelularAdicionalMae.toString(),
                    ),
                    SizedBox(height: 10),
                    InputMostrar(
                      hintText: "Número de celular adicional",
                      valor: atleta.numeroDeCelularAdicionalPai.toString(),
                    ),
                    SizedBox(height: 10),
                    InputMostrar(
                      hintText: "Número de celular adicional",
                      valor: atleta.numeroDeCelularLocalTrabalho.toString(),
                    ),
                    SizedBox(height: 10),
                    InputMostrar(
                      hintText: "Número de celular adicional",
                      valor: atleta.numeroDeCelularResidencial.toString(),
                    ),
                    SizedBox(height: 10),
                    InputMostrar(
                      hintText: "Número de celular adicional",
                      valor: atleta.numeroDeCelularAdicional.toString(),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageFullScreen(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pop(); // Fecha a caixa de diálogo quando a imagem é tocada
            },
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain, // Ajusta a imagem ao tamanho máximo da tela
            ),
          ),
        );
      },
    );
  }
}
