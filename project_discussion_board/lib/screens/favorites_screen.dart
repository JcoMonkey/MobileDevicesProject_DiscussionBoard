import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'home_screen.dart';

/// FavoritesScreen displays favorite topics or boards.
/// Users can navigate to this screen by clicking on the "Favorites" icon in the task bar or by swiping.
/// This screen includes a search bar, a placeholder message for favorites, and the task bar at the bottom.
class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      rightScreen: HomeScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Placeholder for additional options in the future
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Search bar for filtering favorites
            CustomSearchBar(),
            // Placeholder text displayed when there are no favorites
            Expanded(
              child: Center(
                child: Text(
                  'No favorites yet.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
        // TaskBar with 'Favorites' tab selected
        bottomNavigationBar: TaskBar(currentIndex: 0),
      ),
    );
  }
}
