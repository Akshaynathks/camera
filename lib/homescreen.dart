import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cam_app/galleryscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'filehelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;



  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
  }

  Future<void> _takePicture() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        await FileHelper.addImagePath(
            image.path); // Save the captured image path
        // print("Image captured: ${image.path}");
      }
    } catch (e) {
      // print("Error taking picture: $e");
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 244, 45),
        title: const Text('Camera'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GalleryScreen()),
            );
          },
          icon: const Icon(Icons.folder_open),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera_alt),
            label: const Text('Take Picture'),
          ),
        ),
      ),
    );
  }
}
