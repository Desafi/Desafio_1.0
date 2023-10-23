import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void MensagemAwesome(
  BuildContext context,
  String titulo,
  String desc,
) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    showCloseIcon: true,
    title: titulo,
    desc: desc,
    btnOkOnPress: () {},
  ).show();
}
