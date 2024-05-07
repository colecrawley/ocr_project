import 'package:flutter/material.dart';
import 'photo_grid.dart'; // Import PhotoGrid widget

class ViewFolder extends StatelessWidget {
  const ViewFolder({super.key});

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