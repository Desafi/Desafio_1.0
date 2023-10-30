import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:desafio/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAppSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        VerificaTipo(user.uid, context);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginApp()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/images/carregamento.json'),
      nextScreen: LoginApp(),
      splashIconSize: 250,
      duration: 3000,
      backgroundColor: Color.fromARGB(255, 86, 97, 255),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
