import 'package:flutter/material.dart';

class Camera extends StatelessWidget {
  final VoidCallback onPressed;

  const Camera({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset('assets/camera_icon.png',
      width: 50,
      height: 50,
      ), // Replace 'assets/camera_icon.png' with your icon image path
    );
  }
}
