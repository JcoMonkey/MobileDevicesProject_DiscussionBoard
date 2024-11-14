import 'package:flutter/material.dart';

/// CustomSearchBar is a reusable widget providing a search input field.
/// This widget is used in screens where search functionality is needed, such as HomeScreen and TopicScreen.
class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),  // Search icon in the input field
          filled: true,
          fillColor: Colors.grey[200],  // Background color of the search bar
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),  // Rounded corners for the search bar
            borderSide: BorderSide.none,  // No visible border
          ),
        ),
      ),
    );
  }
}
