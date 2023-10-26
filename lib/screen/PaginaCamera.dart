import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PaginaCamera extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const PaginaCamera({Key? key, required this.cameras}) : super(key: key);

  @override
  State<PaginaCamera> createState() => _PaginaCamera();
}

bool botaoFoto = true;
bool botoesSelecionar = false;

class _PaginaCamera extends State<PaginaCamera> {
  XFile? pictureFile;
  late CameraController controller;
  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras![0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Camera"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: pictureFile == null
                    ? CameraPreview(controller)
                    : Image.file(
                        File(pictureFile!.path),
                      ),
              ),
            ),
            //CameraPreview(controller),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 170,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: botaoFoto,
                      child: FloatingActionButton.large(
                        backgroundColor: Colors.white,
                        elevation: 20,
                        onPressed: () async {
                          XFile file = await controller.takePicture();
                          if (mounted) {
                            setState(() {
                              pictureFile = file;
                              botaoFoto = !botaoFoto;
                              botoesSelecionar = !botoesSelecionar;
                            });
                          }
                        },
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: botoesSelecionar,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton.large(
                            backgroundColor: Colors.white,
                            elevation: 20,
                            onPressed: () async {
                              if (mounted) {
                                setState(() {
                                  pictureFile = null;
                                  botaoFoto = !botaoFoto;
                                  botoesSelecionar = !botoesSelecionar;
                                });
                              }
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                          FloatingActionButton.large(
                            backgroundColor: Colors.white,
                            elevation: 20,
                            onPressed: () async {
                              if (mounted) {
                                setState(() {
                                  botaoFoto = !botaoFoto;
                                  botoesSelecionar = !botoesSelecionar;
                                });
                                Navigator.pop(context, pictureFile);
                              }
                            },
                            child: const Icon(
                              Icons.check,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
