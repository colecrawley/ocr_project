import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class ViewFolder extends StatelessWidget {
  final BuildContext context;

  const ViewFolder({required this.context, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _openFolder(context);
      },
      child: const Text('View Notes Folder'),
    );
  }

  Future<void> _openFolder(BuildContext context) async {
    final directory = await getExternalStorageDirectory();
    final folderPath = directory!.path + '/Pictures/saved_notes';
    final folder = Directory(folderPath);
    if (await folder.exists()) {
      OpenFile.open(folderPath); // Open the folder using the open_file package
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Folder does not exist')),
      );
    }
  }
}
