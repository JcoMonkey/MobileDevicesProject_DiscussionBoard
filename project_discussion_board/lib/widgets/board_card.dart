import 'package:flutter/material.dart';
import '../screens/topic_screen.dart';

class BoardCard extends StatelessWidget {
  final String boardName;

  BoardCard({required this.boardName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TopicScreen()),
        );
      },
      child: Container(
        color: Colors.grey[300], // Placeholder color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 8),
            Text(boardName),
          ],
        ),
      ),
    );
  }
}
