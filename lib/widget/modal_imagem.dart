import 'package:camera/camera.dart';
import 'package:desafio/screen/pagina_camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ModalImagem extends StatefulWidget {
  final Function(String) onPhotoSelected;

  const ModalImagem({
    super.key,
    required this.onPhotoSelected,
  });

  @override
  State<ModalImagem> createState() => _ModalImagemState();
}

XFile? pictureFile;
final storage = FirebaseStorage.instance;

class _ModalImagemState extends State<ModalImagem> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
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
                  XFile? foto =
                      await availableCameras().then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaginaCamera(cameras: value),
                          )));

                  widget.onPhotoSelected(foto!.path);
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
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  widget.onPhotoSelected(image!.path);
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
