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

                  // Reference ref =
                  //     storage.ref().child("images/${Uuid().v4()}.jpg");

                  // Reference reference = FirebaseStorage.instance.ref();
                  // Reference referenceDirImages = reference.child('images');

                  // Reference referenceImageToUpload =
                  //     referenceDirImages.child(Uuid().v4());

                  // try {
                  //   await referenceImageToUpload.putFile(File(foto!.path));

                  //   imageUrl = await referenceImageToUpload.getDownloadURL();
                  // } catch (e) {
                  //   // ...
                  // }

                  // Reference ref =
                  //     storage.ref().child("images/${Uuid().v4()}.jpg");
                  // await ref.putFile(File(foto!.path));
                  // String imageUrl = await ref.getDownloadURL();
                  // print("URL da imagem: $imageUrl");
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
