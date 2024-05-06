import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'settings_button.dart'; // Import the Settings screen
import 'phone_gallery.dart'; // Import the bottom left button
import 'camera.dart'; // Import the bottom middle button
import 'saved_notes.dart'; // Import the bottom right button
import 'save_button.dart';
import 'notes_folder.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = '';
  File? image;
  final ImagePicker _imagePicker = ImagePicker();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(width: 100),
                Container(
                  height: 280,
                  width: 250,
                  margin: const EdgeInsets.only(top: 70),
                  padding: const EdgeInsets.only(left: 28, bottom: 5, right: 18),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/note.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        result,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 110, right: 125), //140 right //top 20
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/pin.png',
                          height: 200,
                          width: 200,
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 100,
                          height: 150,
                          child: image != null
                              ? Image(
                            image: FileImage(image!),
                            width: 140,
                            height: 192,
                            fit: BoxFit.fill,
                          )
                              : Container(), // Empty container when no image is selected
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            Positioned( //phone gallery button
              bottom: 20,
              left: 50,
              child: PhoneGallery(
                onPressed: pickImageFromGallery,
                pickImageFromGallery: pickImageFromGallery,

              ),

            ),
            Positioned( //phone camera button
              bottom: 20,
              left: 200,
              child: Camera(
                onPressed: pickImageFromCamera,
                pickImageFromCamera: pickImageFromCamera,
              ),

            ),
            Positioned( //saved notes button with clipboard functionality
              bottom: 20,
              right: 40,
              child: SavedNotesButton(
                result: result,
              ),

            ),
            Positioned( // Save Notes to Folder-------------------------------
              bottom: 120,
              left: 240,
              child: SaveButton(
                image: image, // Pass the image variable here

              ),
            ),
            Positioned(
              bottom: 200,
              left: 240,
              child: ViewFolder(context: context),
            ),

            Positioned(
              top: 20,
              right: 20,
              child: Container(
                //decoration: BoxDecoration(
                //shape: BoxShape.circle,
                //color: Colors.white,
                //),
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  onPressed: () {
                    // Navigate to settings screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Settings()),
                    );
                  },
                  icon: Image.asset(
                    'assets/settings.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
