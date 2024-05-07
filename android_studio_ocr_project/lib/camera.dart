import 'package:flutter/material.dart';

class Camera extends StatelessWidget {
  final VoidCallback onPressed;
  final Function() pickImageFromCamera;

  const Camera({super.key, required this.onPressed, required this.pickImageFromCamera});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Add functionality for the Camera button
        pickImageFromCamera();
      },
      icon: Image.asset(
        'assets/camera_icon.png',
        width: 50,
        height: 50,
      ),
    );
  }
}
