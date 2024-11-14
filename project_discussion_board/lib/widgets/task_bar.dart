import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/profile_screen.dart';

/// TaskBar is a BottomNavigationBar widget used in multiple screens.
/// It provides navigation between Favorites, Home, and Profile screens.
class TaskBar extends StatelessWidget {
  final int currentIndex;  // Index of the currently selected tab

  TaskBar({this.currentIndex = 1}); // Default to 'Home' tab

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.star),  // Icon for Favorites tab
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),  // Icon for Home tab
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),  // Icon for Profile tab
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,  // Set the selected tab
      onTap: (index) {
        if (index == 0 && currentIndex != 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FavoritesScreen()),
          );
        } else if (index == 1 && currentIndex != 1) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false, // Clears the entire navigation stack
          );
        } else if (index == 2 && currentIndex != 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        }
      },
    );
  }
}
