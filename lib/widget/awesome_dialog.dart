import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void MensagemAwesome(
  BuildContext context,
  String titulo,
  String desc,
) {
  AwesomeDialog(
    context: context,
    dismissOnTouchOutside: false,
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    showCloseIcon: false,
    title: titulo,
    desc: desc,
    btnOkOnPress: () {
      Navigator.pop(context);
    },
  ).show();
}
