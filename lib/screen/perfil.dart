import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/main.dart';
import 'package:desafio/widget/botao_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;

class MeuPerfilApp extends StatefulWidget {
  const MeuPerfilApp({super.key});

  @override
  State<MeuPerfilApp> createState() => _MeuPerfilAppState();
}

Map<String, dynamic>? user;
bool carregando = true;

class _MeuPerfilAppState extends State<MeuPerfilApp> {
  @override
  void initState() {
    _carregarInfoUser();

    super.initState();
  }

  Future<void> _carregarInfoUser() async {
    await db
        .collection("Usuarios")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((snapshot) {
      setState(() {
        user = snapshot.data();
        carregando = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(2, 76, 99, 1),
        automaticallyImplyLeading: false,
      ),
      body: carregando == true
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.black, size: 200))
          : SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: HeaderCurvedContainer(),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 90,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            user!["Tipo"],
                            style: TextStyle(
                              fontSize: 35,
                              letterSpacing: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white12, width: 2),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/person.jpg'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 450,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(user!["Nome"],
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24),
                                )),
                            Text(user!["Email"],
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                )),
                            const SizedBox(
                              height: 60,
                            ),
                            BotaoUI(
                              hintText: "Editar",
                              icone: const Icon(
                                Icons.edit_outlined,
                                size: 25,
                              ),
                              cor: Colors.grey[400],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BotaoUI(
                              hintText: "Sair",
                              icone: const Icon(
                                Icons.exit_to_app,
                                size: 25,
                              ),
                              cor: Colors.red[500],
                              onTap: () async {
                                await _auth.signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const LoginApp()),
                                    (route) => false);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

// curva do appbar
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color.fromRGBO(2, 76, 99, 1);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
