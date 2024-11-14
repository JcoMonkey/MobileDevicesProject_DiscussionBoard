import 'package:flutter/material.dart';
import '../screens/topic_detail_screen.dart';

class TopicCard extends StatelessWidget {
  final String topicTitle;

  TopicCard({required this.topicTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopicDetailScreen(topicTitle: topicTitle),
          ),
        );
      },
      child: Container(
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 8),
            Text(topicTitle),
          ],
        ),
      ),
    );
  }
}
