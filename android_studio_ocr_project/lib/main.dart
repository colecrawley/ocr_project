// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart'; // Import the AppState class
import 'home.dart'; // Import Home screen
import 'start_menu.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OCR Project',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StartMenu(),
    );
  }
}
