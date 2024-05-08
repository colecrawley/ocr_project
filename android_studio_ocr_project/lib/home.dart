import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'settings_button.dart'; // Import the Settings screen
// Import the bottom left button
// Import the bottom middle button
// Import the StartMenu screen
import 'saved_notes.dart'; // Import the bottom right button
import 'save_button.dart';
import 'photo_grid.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = '';
  File? image;
  final ImagePicker _imagePicker = ImagePicker();

  bool darkMode = false; // Track dark mode state

  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        performImageLabelling();
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        performImageLabelling();
      });
    }
  }

  Future<void> performImageLabelling() async {
    if (image != null) {
      final inputImage = InputImage.fromFilePath(image!.path);
      final textRecognizer = GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognisedText = await textRecognizer.processImage(inputImage);

      setState(() {
        result = recognisedText.text;
      });
    }
  }

  void toggleDarkMode(bool value) {
    setState(() {
      darkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = darkMode ? ThemeData.dark() : ThemeData.light();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top bar with padding
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              // Add vertical padding
              child: Container(
                height: 60,
                color: darkMode ? Color(0xFF2e333a) : Color(0xFFF4F4F8),
                // Top bar color using hex code
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context); // Navigate back to the previous screen
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    IconButton(
                      onPressed: () {
                        // Navigate to settings screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Settings(
                              darkMode: darkMode, // Pass darkMode parameter
                              onDarkModeChanged: toggleDarkMode,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
            ),
            // Middle section: OCR text and image
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                // Add padding here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // OCR text
                    Expanded(
                      child: Container(
                        color: darkMode ? Color(0xFF394048) : Color(0xFFfffbfe), // White color for background
                        child: Center(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              result,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Image being OCR'd
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: image != null
                              ? DecorationImage(
                            image: FileImage(image!),
                            fit: BoxFit.contain,
                            // Adjust the image size to fit within the padding
                          )
                              : null,
                        ),
                        child: Center(
                          child: image != null
                              ? null
                              : const Text(
                            'No image selected',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Copy to clipboard and save note buttons with padding
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SavedNotesButton(result: result),
                  const SizedBox(width: 16), // Add spacing between buttons
                  SaveButton(image: image),
                ],
              ),
            ),
            // Bottom bar with padding
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              // Add vertical padding
              child: Container(
                color: darkMode ? Color(0xFF2e333a) : Color(0xFFF4F4F8),
                // Bottom bar color using hex code
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: pickImageFromGallery,
                      icon: Icon(Icons.photo),
                      color: Color(0xFFFE4A49),
                      // Gallery button color
                    ),
                    IconButton(
                      onPressed: pickImageFromCamera,
                      icon: Icon(Icons.camera_alt),
                      color: Color(0xFF2AB7CA),
                      // Camera button color
                    ),
                    Transform.rotate(
                      angle: -1.5708,
                      // Rotate saved_notes icon by -90 degrees (in radians)
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhotoGrid(
                                  darkMode: darkMode,
                                  onDarkModeChanged: toggleDarkMode,
                                )),
                          );
                        },
                        icon: Icon(Icons.note),
                        color: Color(0xFFFED766),
                        // Saved notes button color
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

