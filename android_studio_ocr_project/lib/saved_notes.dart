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
      child: ElevatedButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: result));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Text copied to clipboard')),
          );
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4586FC)),
        ),
        child: const SizedBox(
          width: 100,
          height: 50,
          child: Center(
            child: Text(
              'Copy',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

