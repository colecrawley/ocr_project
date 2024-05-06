import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SavedNotesButton extends StatelessWidget {
  final String result;

  const SavedNotesButton({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 40,
      child: IconButton(
        icon: Image.asset(
          'assets/saved_notes_icon.png', // asset path
          width: 40, // width
          height: 40, // height
        ),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: result));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Text copied to clipboard')),
          );
        },
      ),
    );
  }
}

