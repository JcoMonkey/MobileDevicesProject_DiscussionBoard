import 'package:flutter/material.dart';

class SwipeNavigator extends StatelessWidget {
  final Widget child;
  final Widget? leftScreen;
  final Widget? rightScreen;

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
