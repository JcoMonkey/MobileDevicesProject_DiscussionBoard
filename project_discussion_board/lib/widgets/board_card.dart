import 'package:flutter/material.dart';
import '../screens/topic_screen.dart';

/// BoardCard is a widget representing an individual board in the HomeScreen grid.
/// Tapping on this widget navigates to the TopicScreen for that board.
class BoardCard extends StatelessWidget {
  final String boardName;  // Name of the board to display
  final String boardImageURL; //Image of the board to display

  // Constructor to initialize board name
  BoardCard({required this.boardName, required this.boardImageURL});


  // Convert a map into a BoardCard object
  factory BoardCard.fromMap(Map<String, dynamic> map)
  {
    return BoardCard(
      boardName: map['boardName'],
      boardImageURL: map['imageURL'],
    );
  }
    

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to TopicScreen when the board is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TopicScreen()),
        );
      },
      child: Container(
        color: Colors.grey[300], // Background color for the board card
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              boardImageURL,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Image fully loaded
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return Icon(
                  Icons.image,  // Placeholder icon representing the board
                  size: 80,
                  color: Colors.grey,
                );
              },
            ),
            SizedBox(height: 8),
            Text(boardName, ), // Display the board's name
          ],
        ),
      ),
    );
  }
}
