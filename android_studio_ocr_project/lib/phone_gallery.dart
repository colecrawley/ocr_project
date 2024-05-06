import 'package:flutter/material.dart';

class PhoneGallery extends StatelessWidget {
  final VoidCallback onPressed;
  final Function() pickImageFromGallery;

  const PhoneGallery({required this.onPressed, required this.pickImageFromGallery});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Add functionality for the PhoneGallery button
        pickImageFromGallery();
      },
      icon: Image.asset(
        'assets/phone_gallery_icon.png',
        width: 50,
        height: 50,
      ),
    );
  }
}
