import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SavedNotesButton extends StatelessWidget {
  final String result;

  const SavedNotesButton({required this.result, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 40,
      child: ElevatedButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: result));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Text copied to clipboard')),
          );
        },
        child: const Text(
          'Copy to Clipboard',
          style: TextStyle(color: Color(0xFF4586FC)), // Setting text color
        ),
      ),
    );
  }
}

