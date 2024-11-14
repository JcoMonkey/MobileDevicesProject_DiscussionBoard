import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'home_screen.dart';

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
                // Placeholder for more actions
              },
            ),
          ],
        ),
        body: Column(
          children: [
            CustomSearchBar(),
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
        bottomNavigationBar: TaskBar(currentIndex: 0),
      ),
    );
  }
}
