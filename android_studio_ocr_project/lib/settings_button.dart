import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Settings extends StatelessWidget {
  final bool darkMode;
  final Function(bool) onDarkModeChanged;

  const Settings({
    Key? key,
    required this.darkMode,
    required this.onDarkModeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: darkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: darkMode ? const Color(0xFF2e333a) : Color(0xFFf4f4f8),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: darkMode ? Colors.white : Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: darkMode ? const Color(0xFF394048) : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dark Mode',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: darkMode ? Colors.white : Colors.black,
              ),
            ),
            Switch(
              value: darkMode,
              onChanged: onDarkModeChanged,
              activeColor: const Color(0xFF2AB7CA),
            ),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              child: const Text('Erase All Notes in Folder'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text('All notes saved on this application will be erased permanently.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _eraseAllNotes(context);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _eraseAllNotes(BuildContext context) async {
    final directory = await getExternalStorageDirectory();
    final folderPath = '${directory!.path}/Pictures/saved_notes';
    final folder = Directory(folderPath);

    try {
      if (await folder.exists()) {
        await folder.delete(recursive: true); // Delete the folder and its contents
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All notes have been erased.')
              ,duration: Duration(seconds: 1)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No notes to erase.')
              ,duration: Duration(seconds: 1)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to erase notes. Please try again later.')
            ,duration: Duration(seconds: 1)),
      );
    }
  }
}
