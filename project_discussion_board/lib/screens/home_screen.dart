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

  ///can potentially access this from a database later
  final List<String> boardCategories = ['Gaming', 'Science', 'Art', 'Sports'];
  final List<String> boardImageURLs = [
    'https://images.pexels.com/photos/3165335/pexels-photo-3165335.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
    'https://media.istockphoto.com/photos/science-laboratory-research-and-development-concept-microscope-with-picture-id842452752?k=20&m=842452752&s=612x612&w=0&h=awmur8CZkHiBm0vbaSY5dPT_jTJWdY3vu5aVEhm0vFA=',
    'https://media.istockphoto.com/photos/set-of-watercolor-paints-brushes-for-painting-picture-id517497166?k=20&m=517497166&s=612x612&w=0&h=Nv7ZZSVNsXG9MoWt8MCvsdwfrNqGc-Azx3ixDIrvzT4=',
    'https://media.istockphoto.com/photos/closeup-of-sport-balls-and-equipment-picture-id1136317340?k=20&m=1136317340&s=612x612&w=0&h=vnhEFELSJ9lqKBc6QZHntFY7zco2zNohZJxJRu9dWjk=',
  ];

  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      leftScreen: FavoritesScreen(),
      rightScreen: ProfileScreen(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('HyperBoards'),
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
                  // return BoardCard(boardName: 'Board ${index + 1}');
                  return BoardCard(boardName: boardCategories[index],boardImageURL: boardImageURLs[index]);
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
