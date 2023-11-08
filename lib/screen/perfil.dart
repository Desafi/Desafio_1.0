import 'package:desafio/main.dart';
import 'package:desafio/widget/botao_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeuPerfilApp extends StatelessWidget {
  const MeuPerfilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(2, 76, 99, 1),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: HeaderCurvedContainer(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(padding: EdgeInsets.all(25)),
                    Text('João Antonio',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24),
                        )),
                    Text('joaoantoniolaraujo@gmail.com',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        )),
                    const SizedBox(
                      height: 60,
                    ),
                    BotaoUI(
                      hintText: "Editar",
                      icone: Icon(
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
                      icone: Icon(
                        Icons.exit_to_app,
                        size: 25,
                      ),
                      cor: Colors.red[500],
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => LoginApp()),
                            (route) => false);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Perfil",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white12, width: 2),
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
        ],
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
