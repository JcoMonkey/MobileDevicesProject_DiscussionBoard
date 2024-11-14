import 'package:flutter/material.dart';

/// SwipeNavigator is a wrapper widget that enables swipe-based navigation between screens.
/// This widget detects left and right swipes and navigates to specified screens if a swipe is detected.
///
/// Usage:
///   Wrap the main content of a screen in SwipeNavigator and specify the leftScreen and rightScreen parameters.
class SwipeNavigator extends StatelessWidget {
  final Widget child;  // The main content to be displayed within the SwipeNavigator
  final Widget? leftScreen;  // Screen to navigate to on left swipe
  final Widget? rightScreen; // Screen to navigate to on right swipe

  SwipeNavigator({required this.child, this.leftScreen, this.rightScreen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0 && rightScreen != null) {
          // Swipe left to go to the rightScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => rightScreen!),
          );
        } else if (details.primaryVelocity! > 0 && leftScreen != null) {
          // Swipe right to go to the leftScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => leftScreen!),
          );
        }
      },
      child: child,
    );
  }
}
