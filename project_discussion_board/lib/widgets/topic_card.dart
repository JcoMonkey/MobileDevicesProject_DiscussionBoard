import 'package:flutter/material.dart';
import '../screens/topic_detail_screen.dart';

/// TopicCard is a widget representing an individual topic in the TopicScreen grid.
/// Tapping on this widget navigates to the TopicDetailScreen for that topic.
class TopicCard extends StatelessWidget {
  final String topicTitle;  // Title of the topic to display

  // Constructor to initialize topic title
  TopicCard({required this.topicTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to TopicDetailScreen when the topic is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopicDetailScreen(topicTitle: topicTitle),
          ),
        );
      },
      child: Container(
        color: Colors.grey[300], // Background color for the topic card
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,  // Placeholder icon representing the topic
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 8),
            Text(topicTitle), // Display the topic's title
          ],
        ),
      ),
    );
  }
}
