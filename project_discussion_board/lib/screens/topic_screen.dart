import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/topic_card.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class TopicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      leftScreen: FavoritesScreen(),
      rightScreen: ProfileScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Topics'),
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
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return TopicCard(topicTitle: 'Topic ${index + 1}');
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
