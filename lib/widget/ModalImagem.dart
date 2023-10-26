import 'package:camera/camera.dart';
import 'package:desafio/screen/PaginaCamera.dart';
import 'package:flutter/material.dart';

class ModalImagem extends StatefulWidget {
  const ModalImagem({
    super.key,
  });

  @override
  State<ModalImagem> createState() => _ModalImagemState();
}

class _ModalImagemState extends State<ModalImagem> {
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () async {
                  XFile? fotoSelecionada =
                      await availableCameras().then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaginaCamera(cameras: value),
                          )));
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 70,
                    ),
                    Text(
                      "Tirar foto",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  //abrirGaleria()
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      size: 70,
                    ),
                    Text(
                      "Escolher foto",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
