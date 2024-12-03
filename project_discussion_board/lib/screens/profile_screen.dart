import 'package:flutter/material.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'home_screen.dart';
import '../widgets/theme_provider.dart';
import 'package:provider/provider.dart';

/// ProfileScreen displays the user's profile information.
/// Users can access this screen by selecting "Profile" in the task bar.
/// This screen includes a placeholder for profile content and the task bar at the bottom.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SwipeNavigator(
      leftScreen: const HomeScreen(),
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
            'Profile page content will go here. Theme color is ${themeProvider.primarySwatch}', //TODO: update when you click the action button and not just when you change page
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.format_paint_rounded),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ChangeThemeColor();
                  });
            }),
        // TaskBar with 'Profile' tab selected
        bottomNavigationBar: const TaskBar(currentIndex: 2),
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SimpleDialog(
      title: const Text('Select color'),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            setState(() {
              themeProvider.changePrimarySwatch(Colors.purple);
            });
            Navigator.pop(context);
          },
          child: const Text('Purple'),
        ),
        SimpleDialogOption(
          onPressed: () {
            setState(() {
              themeProvider.changePrimarySwatch(Colors.indigo);
            });
            Navigator.pop(context);
          },
          child: const Text('Indigo'),
        ),
      ],
    );
  }
}
