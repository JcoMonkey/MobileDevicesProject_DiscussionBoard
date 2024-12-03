import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Change theme from anywhere in the app
class ThemeProvider with ChangeNotifier {
  MaterialColor _primarySwatch = Colors.blue;

  MaterialColor get primarySwatch => _primarySwatch;

  ThemeProvider() {
    _loadPreferredColor();
  }

  void changePrimarySwatch(MaterialColor color) {
    if (_primarySwatch != color) {  // Check if the color is already the same
      _primarySwatch = color;
      notifyListeners();  // Notify listeners to rebuild the widgets that depend on this value
      _savePreferredColor();
    }
  }

  Future<void> _loadPreferredColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedColorValue = prefs.getInt('primarySwatch');
    if (savedColorValue != null) {
      _primarySwatch = _getMaterialColorFromValue(savedColorValue);
      notifyListeners();
    }
  }

  _savePreferredColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('primarySwatch', _primarySwatch.value);
  }

  MaterialColor _getMaterialColorFromValue(int colorValue) {
    // Map the color value back to the corresponding MaterialColor
    if (colorValue == Colors.blue.value) return Colors.blue;
    if (colorValue == Colors.purple.value) return Colors.purple;
    if (colorValue == Colors.indigo.value) return Colors.indigo;
    return Colors.blue; // Default color
  }
}
