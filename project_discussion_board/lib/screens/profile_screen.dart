import 'package:flutter/material.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'home_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      leftScreen: HomeScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Placeholder for more actions
              },
            ),
          ],
        ),
        body: Center(
          child: Text(
            'Profile page content will go here.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
        bottomNavigationBar: TaskBar(currentIndex: 2),
      ),
    );
  }
}
