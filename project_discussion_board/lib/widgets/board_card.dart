import 'package:flutter/material.dart';
import '../screens/topic_screen.dart';

/// BoardCard is a widget representing an individual board in the HomeScreen grid.
/// Tapping on this widget navigates to the TopicScreen for that board.
class BoardCard extends StatelessWidget {
  final String boardId; // Unique ID for the board
  final String boardName; // Name of the board to display
  final String boardImageURL; // Image of the board to display

  // Constructor to initialize board details
  const BoardCard({
    super.key,
    required this.boardId,
    required this.boardName,
    required this.boardImageURL,
  });

  // Convert a map into a BoardCard object
  factory BoardCard.fromMap(String boardId, Map<String, dynamic> map) {
    return BoardCard(
      boardId: boardId,
      boardName: map['boardName'] ?? 'Unknown Board',
      boardImageURL: map['imageURL'] ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to TopicScreen and pass the boardId and boardName
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopicScreen(
              boardId: boardId,
              boardName: boardName, // Pass the board name
            ),
          ),
        );
      },
      child: Container(
        color: Colors.grey[300], // Background color for the board card
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              boardImageURL,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Image fully loaded
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return const Icon(
                  Icons.image, // Placeholder icon representing the board
                  size: 80,
                  color: Colors.grey,
                );
              },
            ),
            const SizedBox(height: 8),
            Text(boardName), // Display the board's name
          ],
        ),
      ),
    );
  }
}
