import 'package:flutter/material.dart';
import 'package:project_discussion_board/main.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'home_screen.dart';

String favColor = "blue";

/// ProfileScreen displays the user's profile information.
/// Users can access this screen by selecting "Profile" in the task bar.
/// This screen includes a placeholder for profile content and the task bar at the bottom.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      leftScreen: HomeScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Placeholder for additional options in the future
              },
            ),
          ],
        ),
        // Centered placeholder text for the profile content
        body: Center(
          child: Text(
            'Profile page content will go here. Fav color is $favColor', //TODO: update when you click the action button and not just when you change page
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.format_paint_rounded),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ChangeThemeColor();
                  });
            }),
        // TaskBar with 'Profile' tab selected
        bottomNavigationBar: TaskBar(currentIndex: 2),
      ),
    );
  }
}

// Changes theme color
class ChangeThemeColor extends StatefulWidget {
  const ChangeThemeColor({super.key});

  @override
  State<ChangeThemeColor> createState() => _ChangeThemeColorState();
}

class _ChangeThemeColorState extends State<ChangeThemeColor> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Select color'),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            setState(() {
              favColor = "purple";
            });
            Navigator.pop(context);
          },
          child: const Text('Purple'),
        ),
        SimpleDialogOption(
          onPressed: () {
            setState(() {
              favColor = "indigo";
            });
            Navigator.pop(context);
          },
          child: const Text('Indigo'),
        ),
      ],
    );
  }
}
