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
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text("Informações do Atleta"),
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
                  backgroundImage: AssetImage('assets/images/feio.png'),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Data de Nascimento",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Número de Celular",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Número de Emergência",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Nacionalidade",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Naturalidade",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "RG",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "CPF",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Sexo",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "CEP",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Bairro",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Endereço",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Convenio Medico",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Estilos",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Prova",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),

              //imagens
              GestureDetector(
                onTap: () {
                  _showImageFullScreen('assets/images/atleta.png');
                },
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: "Imagem Atestado",
                    suffixIcon: Icon(Icons.image),
                  ),
                  onTap: () {
                    _showImageFullScreen(
                        'assets/images/atleta.png'); // Abre a imagem quando o campo é tocado
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showImageFullScreen('assets/images/atleta.png');
                },
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: "Imagem RG",
                    suffixIcon: Icon(Icons.image),
                  ),
                  onTap: () {
                    _showImageFullScreen('assets/images/atleta.png');
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showImageFullScreen('assets/images/atleta.png');
                },
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: "Imagem CPF",
                    suffixIcon: Icon(Icons.image),
                  ),
                  onTap: () {
                    _showImageFullScreen('assets/images/atleta.png');
                  },
                ),
              ),

              GestureDetector(
                onTap: () {
                  _showImageFullScreen('assets/images/atleta.png');
                },
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: "Imagem Comprovante de Residencia",
                    suffixIcon: Icon(Icons.image),
                  ),
                  onTap: () {
                    _showImageFullScreen('assets/images/atleta.png');
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showImageFullScreen('assets/images/atleta.png');
                },
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: "Imagem Regulamento do Atleta",
                    suffixIcon: Icon(Icons.image),
                  ),
                  onTap: () {
                    _showImageFullScreen('assets/images/atleta.png');
                  },
                ),
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
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: "Nome da Mãe",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: "Nome do Pai",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: "Clube de Origem",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: "Alergia a Medicamentos",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: "Numero de celular adicional",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
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
