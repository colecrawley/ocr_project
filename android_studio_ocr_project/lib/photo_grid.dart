import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'image_viewer.dart';

class PhotoGrid extends StatefulWidget {
  const PhotoGrid({Key? key}) : super(key: key);

  @override
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  late List<File> images;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final directory = await getExternalStorageDirectory();
    final folderPath = directory!.path + '/Pictures/saved_notes';
    final folder = Directory(folderPath);
    if (await folder.exists()) {
      setState(() {
        images = folder.listSync().whereType<File>().toList();
        isLoading = false; // Images are loaded, set isLoading to false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Notes')),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(), // Show loading indicator
      )
          : GridView.builder(
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageViewer(imageProvider: FileImage(images[index])),
                ),
              );
            },
            child: Stack(
              children: [
                Image.file(images[index]),
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteImage(images[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _deleteImage(File image) async {
    await image.delete();
    setState(() {
      images.remove(image);
    });
  }
}