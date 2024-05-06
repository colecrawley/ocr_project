import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  //final Function() pickImageFromCamera;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Add functionality for the Camera button
        //pickImageFromCamera();
      },
      icon: Image.asset(
        'assets/camera_icon.png',
        width: 50,
        height: 50,
      ),
    );
  }
}
