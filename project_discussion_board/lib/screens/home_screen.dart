import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/board_card.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

/// HomeScreen is the main screen displaying a list of boards.
/// Users can access this screen from any other screen by selecting "Home" in the task bar.
/// This screen includes a search bar, a grid of board cards, and the task bar at the bottom.
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      leftScreen: FavoritesScreen(),
      rightScreen: ProfileScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Boards'),
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
            // Search bar for filtering boards
            CustomSearchBar(),
            // GridView showing list of board cards
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4, // Placeholder count for boards
                itemBuilder: (context, index) {
                  return BoardCard(boardName: 'Board ${index + 1}');
                },
              ),
            ),
          ],
        ),
        // TaskBar with 'Home' tab selected
        bottomNavigationBar: TaskBar(currentIndex: 1),
      ),
    );
  }
}
