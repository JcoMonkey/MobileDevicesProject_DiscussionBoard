import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.0), // Adjust padding for compact look
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[200], // Light background color for the search bar
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0), // Smooth, rounded corners
            borderSide: BorderSide.none, // No border outline
          ),
        ),
      ),
    );
  }
}
