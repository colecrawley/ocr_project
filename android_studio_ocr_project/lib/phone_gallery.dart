import 'package:flutter/material.dart';

class PhoneGallery extends StatelessWidget {
  final VoidCallback onPressed;

  const PhoneGallery({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Add functionality for the PhoneGallery button

        //FOR TESTING BUTTON FUNCTIONALITY can delete from here
        //this testing shows a placeholder image
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Image.asset('assets/placeholder.png'),
            );
          },
        ); //can just click anywhere not on the image on the phone screen to exit
        //DELETE UP TO AND INCLUDING THIS LINE FOR ADDING FUNCTIONALITY

      },
      icon: Image.asset(
        'assets/phone_gallery_icon.png',
        width: 50,
        height: 50,
      ),
    );
  }
}
