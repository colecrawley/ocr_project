import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final ImageProvider imageProvider;

  const ImageViewer({required this.imageProvider, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PhotoView(
          imageProvider: imageProvider,
          backgroundDecoration: BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}