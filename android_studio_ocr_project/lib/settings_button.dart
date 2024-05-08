import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  final bool darkMode;
  final Function(bool) onDarkModeChanged;

  const Settings({
    Key? key,
    required this.darkMode,
    required this.onDarkModeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: darkMode ? Colors.white : Colors.black, // Change text color based on dark mode
          ),
        ),
        backgroundColor: darkMode ? const Color(0xFF2e333a) : Color(0xFFf4f4f8), // Dark mode color or white
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: darkMode ? Colors.white : Colors.black, // Change back button color based on dark mode
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: darkMode ? const Color(0xFF394048) : Colors.white, // Dark mode color or white for background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dark Mode',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: darkMode ? Colors.white : Colors.black, // Change text color based on dark mode
              ),
            ),
            Switch(
              value: darkMode,
              onChanged: onDarkModeChanged,
              activeColor: const Color(0xFF2AB7CA), // Change the color of the Switch when it's toggled
            ),
          ],
        ),
      ),
    );
  }
}
