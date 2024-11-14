import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/board_card.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

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
                // Placeholder for more actions
              },
            ),
          ],
        ),
        body: Column(
          children: [
            CustomSearchBar(),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return BoardCard(boardName: 'Board ${index + 1}');
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: TaskBar(currentIndex: 1),
      ),
    );
  }
}
