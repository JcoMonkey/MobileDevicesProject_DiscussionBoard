import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/topic_card.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'home_screen.dart';

/// TopicScreen displays a list of topics within a selected board.
/// Users can access this screen from the board or home screen.
/// This screen includes a search bar, a grid of topic cards, and the task bar at the bottom.
class TopicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      rightScreen: HomeScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Topics'),
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
            // Search bar for filtering topics
            CustomSearchBar(),
            // GridView showing list of topic cards
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,  // Display in 3 columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6, // Placeholder count for topics
                itemBuilder: (context, index) {
                  return TopicCard(topicTitle: 'Topic ${index + 1}');
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
