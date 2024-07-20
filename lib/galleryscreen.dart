import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'filehelper.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late List<FileSystemEntity> _imageFiles = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    List<String> imagePaths = await FileHelper.getImagePaths();
    setState(() {
      _imageFiles = imagePaths.map((path) => File(path)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gallery'),
          centerTitle: true,
          backgroundColor:const Color.fromARGB(255, 208, 244, 45),
        ),
        body: SafeArea(
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4, // Set the number of columns here
            itemCount: _imageFiles.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {},
                child: Image.file(File(_imageFiles[index].path)),
              );
            },
            staggeredTileBuilder: (int index) {
              return const StaggeredTile.fit(1); // Adjust the tile size as needed
            },
          ),
        ));
  }
}

// void clearSharedPreferences() async {
//   final SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.clear();
// }
