import 'package:flutter/material.dart';

class SavedNotes extends StatelessWidget {
  final VoidCallback onPressed;

  const SavedNotes({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset('assets/saved_notes_icon.png',
      width: 50,
      height: 50,
      ), // Replace 'assets/saved_notes_icon.png' with your icon image path
    );
  }
}
