import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PaginaCamera extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const PaginaCamera({Key? key, required this.cameras}) : super(key: key);

  @override
  State<PaginaCamera> createState() => _PaginaCamera();
}

class _PaginaCamera extends State<PaginaCamera> {
  late CameraController controller;
  XFile? pictureFile;

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
            onPressed: () {},
          ),
          title: const Text("Camera"),
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 295,
              child: CameraPreview(controller),
            ),
            //CameraPreview(controller),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Colors.black,
              ),
            ),
          ],
        ));
  }
}
