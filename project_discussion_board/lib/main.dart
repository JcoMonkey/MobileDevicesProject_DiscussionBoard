import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Main entry point of the app, setting up the root widget and initial route.
/// This file initializes the Flutter app and loads the HomeScreen as the starting screen.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.signInAnonymously();
  runApp(const MyApp());
}

/// MyApp is the root widget of the application.
/// It sets up the MaterialApp, which provides essential app-level functionality
/// such as theming, navigation, and localization support.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discussion Board App', // Title of the app
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        primarySwatch:
            Colors.purple, // Sets the primary color theme for the app
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(), // Sets the HomeScreen as the initial route
    );
  }
}

// Change theme from anywhere in the app
// class ThemeProvider with ChangeNotifier {
//   MaterialColor _primarySwatch = Colors.blue;

//   MaterialColor get primarySwatch => _primarySwatch;

//   void changePrimarySwatch(MaterialColor color) {
//     _primarySwatch = color;
//     notifyListeners(); // Notify listeners to rebuild the widgets that depend on this value
//   }
// }
