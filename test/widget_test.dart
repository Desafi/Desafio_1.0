import 'package:desafio/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const botao1 = Key('botaoControle');
  const emailControle = Key('emailKey');
  const senhaControle = Key('senhaKey');

  testWidgets("Teste de widgets na tela de Esqueci senha", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginApp(),
    ));
    await tester.pump();

    expect(find.text('Bem Vindo!'), findsNWidgets(1));
    expect(find.text('Senha'), findsNWidgets(1));
    expect(find.text('Esqueceu sua senha?'), findsNWidgets(1));
    expect(find.text('Entrar'), findsNWidgets(1));
    expect(find.text('E-mail'), findsNWidgets(1));
    expect(find.text('Faça o login e entre na plataforma.'), findsNWidgets(1));
  });

  testWidgets("Teste de login de administrador", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginApp(),
    ));

    final emailAdmin = find.byKey(emailControle);
    expect(emailAdmin, findsOneWidget);
    await tester.enterText(emailAdmin, 'joao@joao.com');

    final senhaAdmin = find.byKey(senhaControle);
    expect(senhaAdmin, findsOneWidget);
    await tester.enterText(senhaAdmin, '123');

    final loginBtn = find.byKey(botao1);
    expect(loginBtn, findsOneWidget);

    await tester.tap(loginBtn);
    await tester.pump();
    expect(find.text('Bem-vindo, Administrador!'), findsNWidgets(1));

    // expect(find.text('Bem-vindo, Administrador!'), findsNWidgets(1));
  });

  // testWidgets("Teste de login de atleta", (tester) async {
  //   await tester.pumpWidget(const MaterialApp(
  //     home: LoginApp(),
  //   ));

  //   final emailAtleta = find.byKey(emailControle);
  //   expect(emailAtleta, findsOneWidget);
  //   await tester.enterText(emailAtleta, 'atl.com');

  //   final senhaAtleta = find.byKey(senhaControle);
  //   expect(senhaAtleta, findsOneWidget);
  //   await tester.enterText(senhaAtleta, '123');

  //   final loginBtnAtleta = find.byKey(botao1);
  //   expect(loginBtnAtleta, findsOneWidget);

  //   await tester.tap(loginBtnAtleta);
  //   await tester.pump();

  //   expect(find.text('Bem-vindo, Atleta!'), findsNWidgets(1));
  // });

  // testWidgets("Teste de login de treinador", (tester) async {
  //   await tester.pumpWidget(const MaterialApp(
  //     home: LoginApp(),
  //   ));

  //   final emailTreinador = find.byKey(emailControle);
  //   expect(emailTreinador, findsOneWidget);
  //   await tester.enterText(emailTreinador, 'trei.com');

  //   final senhaTreinador = find.byKey(senhaControle);
  //   expect(senhaTreinador, findsOneWidget);
  //   await tester.enterText(senhaTreinador, '123');

  //   final loginBtnTreinador = find.byKey(botao1);
  //   expect(loginBtnTreinador, findsOneWidget);

  //   await tester.tap(loginBtnTreinador);
  //   await tester.pump();

  //   expect(find.text('Bem-vindo, Treinador!'), findsNWidgets(1));
  // });
}
