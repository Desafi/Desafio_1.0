import 'dart:async';
import 'package:desafio/widget/botao_cronometro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: CronometroApp(),
//     );
//   }
// }

class CronometroApp extends StatefulWidget {
  const CronometroApp({super.key});

  @override
  State<CronometroApp> createState() => _CronometroAppState();
}

class _CronometroAppState extends State<CronometroApp> {
  bool enviar = false;
  bool botaoRetomar = false;
  bool apareceBotoes = false;
  bool clicouVolta = false;
  bool cronometroRodando = false;
  bool controlaBtnIniciar = true;
  bool pausaCronometro = false;
  bool controlaLista = false;
  var voltasGeral = [];
  int milesegundos = 0;
  int segundos = 0;
  int minutos = 0;
  late Timer cronometro;
  bool controlaBtn = false;

  var voltas = [];
  int milesegundosVolta = 0;
  int segundosVolta = 0;
  int minutosVolta = 0;
  late Timer cronometroVolta;

  void iniciaCronometro() {
    controlaBtn = !controlaBtn;
    controlaLista = !controlaLista;

    cronometro = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (!pausaCronometro) {
        setState(() {
          milesegundos++;

          if (milesegundos == 100) {
            segundos++;
            milesegundos = 0;
          }
          if (segundos == 60) {
            minutos++;
            segundos = 0;
          }
        });
      }
//terminar (minutos == 30 && segundos == 2 && milesegundos == 0)
      if (segundos == 2 && milesegundos == 0) {
        controlaBtn = false;
        pausaCronometro = true;
        enviar = true;
        botaoRetomar = false;
        fezVolta();
      }
    });
  }

  void iniciaCronometroVolta() {
    cronometroVolta = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (!pausaCronometro) {
        setState(() {
          milesegundosVolta++;

          if (milesegundosVolta == 100) {
            segundosVolta++;
            milesegundosVolta = 0;
          }
          if (segundosVolta == 60) {
            minutosVolta++;
            segundosVolta = 0;
          }
        });
      }
    });
  }

  void fezVolta() {
    String voltaGeral =
        "${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}.${milesegundos.toString().padLeft(2, '0')}";
    voltasGeral.add(voltaGeral);

    String volta =
        "${minutosVolta.toString().padLeft(2, '0')}:${segundosVolta.toString().padLeft(2, '0')}.${milesegundosVolta.toString().padLeft(2, '0')}";
    voltas.add(volta);

    milesegundosVolta = 0;
    segundosVolta = 0;
    minutosVolta = 0;
  }

  void resetCronometro() {
    setState(() {
      enviar = false;
      voltasGeral.clear();
      voltas.clear();
      milesegundos = 0;
      segundos = 0;
      minutos = 0;
      milesegundosVolta = 0;
      segundosVolta = 0;
      minutosVolta = 0;
      apareceBotoes = false;
      clicouVolta = false;
      pausaCronometro = false;
      controlaLista = false;
      botaoRetomar = false;
      cronometro.cancel();
      cronometroVolta.cancel();
    });
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}.${milesegundos.toString().padLeft(2, '0')}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${minutosVolta.toString().padLeft(2, '0')}:${segundosVolta.toString().padLeft(2, '0')}.${milesegundosVolta.toString().padLeft(2, '0')}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(height: 25.0),
              if (clicouVolta)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Volta',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Tempo das voltas',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Tempo geral',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 25.0),
              // Containerlista
              Visibility(
                visible: controlaLista,
                child: Container(
                  width: 400.0,
                  height: 400.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD3D3D3),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: voltasGeral.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Alinhar à esquerda
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${index + 1}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                  Text('${voltas[index]}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                  Text('${voltasGeral[index]}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const SizedBox(
                                height: 8.0), // Espaço entre os itens da lista
                          ],
                        );
                      }),
                ),
              ),

              Visibility(
                visible: controlaBtnIniciar,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        iniciaCronometro();
                        iniciaCronometroVolta();
                        setState(() {
                          apareceBotoes = true;
                          controlaBtnIniciar = false;
                          controlaLista = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        minimumSize: const Size(180.0, 60.0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15.0), // Borda arredondada
                        ),
                      ),
                      child: const Text('Iniciar',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),

              Visibility(
                visible: controlaBtn,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        fezVolta();
                        setState(() {
                          clicouVolta = true;
                          controlaLista = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        minimumSize: const Size(180.0, 60.0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15.0), // Borda arredondada
                        ),
                      ),
                      child: const Text('Volta',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                    const SizedBox(width: 15.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controlaBtn = false;
                          pausaCronometro = true;
                          botaoRetomar = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                        minimumSize: const Size(180.0, 60.0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15.0), // Borda arredondada
                        ),
                      ),
                      child: const Text('Parar',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: pausaCronometro,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text(
                                      'Deseja Resetar o cronômetro? ',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    const SizedBox(height: 8.0), //
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BotaoCronometro(
                                          cor: Colors.green,
                                          hintText: "Sim",
                                          icone: Icons.check,
                                          onTap: () {
                                            resetCronometro();
                                            Navigator.pop(context);
                                            setState(() {
                                              controlaBtnIniciar = true;
                                            });
                                          },
                                        ),
                                        BotaoCronometro(
                                          hintText: "Não",
                                          cor: Colors.red,
                                          icone: Icons.cancel,
                                          onTap: () => Navigator.pop(context),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        minimumSize: const Size(180.0, 60.0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15.0), // Borda arredondada
                        ),
                      ),
                      child: const Text('Resetar',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                    const SizedBox(height: 30.0), //
                  ],
                ),
              ),

              Visibility(
                visible: botaoRetomar,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controlaBtn = true;
                      botaoRetomar = false;

                      pausaCronometro = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 140, 255),
                    minimumSize: const Size(180.0, 60.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text('Retomar',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
              Visibility(
                visible: enviar,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enviando relatorio')),
                    );
                    resetCronometro();
                    setState(() {
                      controlaBtnIniciar = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 69, 214, 33),
                    minimumSize: const Size(180.0, 60.0),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.0), // Borda arredondada
                    ),
                  ),
                  child: const Text('Enviar',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
