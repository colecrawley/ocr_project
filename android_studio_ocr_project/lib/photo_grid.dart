import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'image_viewer.dart';
import 'package:gallery_saver/gallery_saver.dart'; // Import gallery_saver package

class PhotoGrid extends StatefulWidget {
  final bool darkMode;
  final Function(bool) onDarkModeChanged;

  const PhotoGrid({Key? key, required this.darkMode, required this.onDarkModeChanged}) : super(key: key);

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
    final folderPath = '${directory!.path}/Pictures/saved_notes';
    final folder = Directory(folderPath);

    // Create the folder if it doesn't exist
    if (!(await folder.exists())) {
      await folder.create(recursive: true);
    }

    // Check if the folder is empty
    final files = folder.listSync().whereType<File>().toList();
    if (files.isNotEmpty) {
      setState(() {
        images = files;
        isLoading = false; // Images are loaded, set isLoading to false
      });
    } else {
      // Folder is empty
      setState(() {
        images = [];
        isLoading = false; // Set isLoading to false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Notes',
          style: TextStyle(
            color: widget.darkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: widget.darkMode ? const Color(0xFF2e333a) : Color(0xFFf4f4f8),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: widget.darkMode ? Colors.white : Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : images.isEmpty
          ? Container(
        color: widget.darkMode ? const Color(0xFF394048) : Color(0xFFfffbfe),
        child: Center(
          child: Text(
            'No notes saved',
            style: TextStyle(fontSize: 18, color: widget.darkMode ? Colors.white : Colors.black), // Adjust text color based on dark mode
          ),
        ),
      )
          : Container(
        color: widget.darkMode ? const Color(0xFF394048) : Color(0xFFfffbfe),
        child: GridView.builder(
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
                    left: -8,
                    child: IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: () {
                        _saveToGallery(images[index]);
                      },
                      color: widget.darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 5,
                    child: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteImage(images[index]);
                      },
                      color: widget.darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  void _saveToGallery(File image) async {
    await GallerySaver.saveImage(image.path);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image saved to gallery'),
        duration: Duration(seconds: 1),
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
