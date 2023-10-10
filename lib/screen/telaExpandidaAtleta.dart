import 'package:desafio/widget/InputMostrar.dart';
import 'package:desafio/widget/InputMostrarFoto.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InfoAtletaApp(),
    );
  }
}

class InfoAtletaApp extends StatefulWidget {
  const InfoAtletaApp({Key? key}) : super(key: key);

  @override
  State<InfoAtletaApp> createState() => _InfoAtletaAppState();
}

class _InfoAtletaAppState extends State<InfoAtletaApp> {
  bool _showMoreInfo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
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
              const InputMostrar(hintText: "Nome Completo"),
             
              const SizedBox(height: 10),
              const InputMostrar(hintText: "E-mail"),

             
              const SizedBox(height: 10),
              const InputMostrar(hintText: "Data de Nascimento"),

              
              const SizedBox(height: 10),
              const InputMostrar(hintText: "Número de Celular"),
            
              const SizedBox(height: 10),
              const InputMostrar(hintText: "Número de Emergência"),
            
              const SizedBox(height: 10),
              const InputMostrar(hintText: "Nacionalidade"),
             
              const SizedBox(height: 10),
              const InputMostrar(hintText: "Naturalidade"),
              
              const SizedBox(height: 10),
              const InputMostrar(hintText: "RG"),
              
              const SizedBox(height: 10),
              const InputMostrar(hintText: "CPF"),
            
              const SizedBox(height: 10),
              const InputMostrar(hintText: "Sexo"),
            
              const SizedBox(height: 10),
              const InputMostrar(hintText: "CEP"),
              
              const SizedBox(height: 10),
              const InputMostrar(hintText: "Bairro"),
             
              const SizedBox(height: 10),
              const InputMostrar(hintText: "Endereço"),
              
              const SizedBox(height: 10),
              const InputMostrar(hintText: "Convênio médico"),
             
              const SizedBox(height: 10),
              const InputMostrar(hintText: "Estilos"),
              
              const SizedBox(height: 10),
              const InputMostrar(hintText: "Prova"),
             
              const SizedBox(height: 10),
              InputMostrarFoto(
                  hintText: "Imagem Atestado",
                  showImageFunction: _showImageFullScreen),
           
              const SizedBox(height: 10),
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    InputMostrar(hintText: "Nome da Mãe"),
                  
                    SizedBox(height: 10),
                    InputMostrar(hintText: "Nome do Pai"),
                   
                    SizedBox(height: 10),
                    InputMostrar(hintText: "Clube de Origem"),
                   
                    SizedBox(height: 10),
                    InputMostrar(hintText: "Alergia a Medicamentos"),
                 
                    SizedBox(height: 10),
                    InputMostrar(hintText: "Número de celular adicional"),
                   
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
