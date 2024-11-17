import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

/// Main entry point of the app, setting up the root widget and initial route.
/// This file initializes the Flutter app and loads the HomeScreen as the starting screen.
void main() {
  runApp(MyApp());
}

/// MyApp is the root widget of the application.
/// It sets up the MaterialApp, which provides essential app-level functionality
/// such as theming, navigation, and localization support.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discussion Board App', // Title of the app
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        primarySwatch: Colors.purple, // Sets the primary color theme for the app
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // Sets the HomeScreen as the initial route
    );
  }
}
