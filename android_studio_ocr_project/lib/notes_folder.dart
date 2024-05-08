import 'package:flutter/material.dart';
import 'photo_grid.dart'; // Import PhotoGrid widget

class ViewFolder extends StatelessWidget {
  final bool darkMode;
  final Function(bool) onDarkModeChanged;

  const ViewFolder({Key? key, required this.darkMode, required this.onDarkModeChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoGrid(
              darkMode: darkMode,
              onDarkModeChanged: onDarkModeChanged,
            ),
          ),
        );
      },
      child: const Text('View Notes Folder'),
    );
  }
}


