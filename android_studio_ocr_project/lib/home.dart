import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart'; // Import ML google Kit package

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
            image: AssetImage('assets/back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
              margin: const EdgeInsets.only(top: 20, right: 140),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/pin.png',
                      height: 240,
                      width: 240,
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        pickImageFromGallery();
                      },
                      onLongPress: () {
                        pickImageFromCamera();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        width: 240,
                        height: 200,
                        child: image != null
                            ? Image.file(image!, width: 140, height: 192, fit: BoxFit.fill)
                            : const Icon(Icons.camera_enhance_sharp, size: 100, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
