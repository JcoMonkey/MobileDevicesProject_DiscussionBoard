import 'package:flutter/material.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'home_screen.dart';

/// ProfileScreen displays the user's profile information.
/// Users can access this screen by selecting "Profile" in the task bar.
/// This screen includes a placeholder for profile content and the task bar at the bottom.
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
                // Placeholder for additional options in the future
              },
            ),
          ],
        ),
        // Centered placeholder text for the profile content
        body: Center(
          child: Text(
            'Profile page content will go here.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
        // TaskBar with 'Profile' tab selected
        bottomNavigationBar: TaskBar(currentIndex: 2),
      ),
    );
  }
}
