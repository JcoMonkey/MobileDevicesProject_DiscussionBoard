import 'package:flutter/material.dart';

// Change theme from anywhere in the app
class ThemeProvider with ChangeNotifier {
  MaterialColor _primarySwatch = Colors.blue;

  MaterialColor get primarySwatch => _primarySwatch;

  void changePrimarySwatch(MaterialColor color) {
    _primarySwatch = color;
    notifyListeners(); // Notify listeners to rebuild the widgets that depend on this value
  }
}
