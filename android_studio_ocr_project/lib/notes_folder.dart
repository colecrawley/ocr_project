import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'photo_grid.dart'; // Import PhotoGrid widget

class ViewFolder extends StatelessWidget {
  const ViewFolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PhotoGrid()),
        );
      },
      child: const Text('View Notes Folder'),
    );
  }
}