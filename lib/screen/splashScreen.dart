import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:desafio/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {

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
