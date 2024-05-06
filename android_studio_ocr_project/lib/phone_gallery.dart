import 'package:flutter/material.dart';

class PhoneGallery extends StatelessWidget {
  final VoidCallback onPressed;

  const PhoneGallery({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset(
          'assets/phone_gallery_icon.png',
      width: 50,
      height: 50,
      ), // Replace 'assets/phone_gallery_icon.png' with your icon image path
    );
  }
}
