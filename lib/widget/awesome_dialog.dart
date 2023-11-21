import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void MensagemAwesome(
  BuildContext context,
  String titulo,
  String desc,
  bool navigator,
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
      if (navigator) {
        Navigator.pop(context);
      }
    },
  ).show();
}
