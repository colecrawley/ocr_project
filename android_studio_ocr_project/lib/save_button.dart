import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SaveButton extends StatelessWidget {
  final File? image; // Image to save

  const SaveButton({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      left: 240,
      child: ElevatedButton(
        onPressed: () {
          if (image != null) {
            _saveImage(image!, context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No image to save')
                  ,duration: Duration(seconds: 1))
            );
          }
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4586FC)), // Setting text color
        ),
        child: const SizedBox(
          width: 100, // Adjust width as needed
          height: 50, // Adjust height as needed
          child: Center(
            child: Text(
              'Save Note',
              style: TextStyle(fontSize: 18), // Adjust font size as needed
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveImage(File image, BuildContext context) async {
    final directory = await getExternalStorageDirectory();
    final picturesDirectory = Directory('${directory!.path}/Pictures');
    if (!await picturesDirectory.exists()) {
      await picturesDirectory.create(recursive: true);
    }
    final newPath = '${picturesDirectory.path}/saved_notes';
    final newDirectory = Directory(newPath);
    if (!await newDirectory.exists()) {
      await newDirectory.create(recursive: true);
    }
    final newImagePath = '$newPath/note_${DateTime.now().millisecondsSinceEpoch}.jpg';
    await image.copy(newImagePath);

  }
}