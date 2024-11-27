import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/topic_detail_screen.dart';

/// TopicCard is a widget representing an individual topic in the TopicScreen grid.
/// Tapping on this widget navigates to the TopicDetailScreen for that topic.
class TopicCard extends StatelessWidget {
  final String topicId;
  final String topicTitle;
  final String boardId;

  // Constructor to initialize topic details
  const TopicCard({
    super.key,
    required this.topicId,
    required this.topicTitle,
    required this.boardId,
  });

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
      onLongPress: () {
        // Show the popup menu on long press
        _showContextMenu(context);
      },
      child: Container(
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(topicTitle),
          ],
        ),
      ),
    );
  }

  /// Displays a popup menu for edit & delete options
  void _showContextMenu(BuildContext context) async {
    final result = await showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        const PopupMenuItem(value: 'edit', child: Text('Edit')),
        const PopupMenuItem(value: 'delete', child: Text('Delete')),
      ],
    );

    if (result == 'edit') {
      _showEditDialog(context);
    } else if (result == 'delete') {
      _showDeleteDialog(context);
    }
  }

  /// Displays a dialog to edit the topic title
  void _showEditDialog(BuildContext context) {
    final _textController = TextEditingController(text: topicTitle);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Topic"),
          content: TextFormField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final newTitle = _textController.text.trim();
                if (newTitle.isNotEmpty && newTitle != topicTitle) {
                  try {
                    await FirebaseFirestore.instance
                        .collection('boardCategories')
                        .doc(boardId)
                        .collection('topics')
                        .doc(topicId)
                        .update({'title': newTitle});

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Topic updated to '$newTitle'")),
                    );
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to update topic")),
                    );
                  }
                }
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  /// Displays a confirmation dialog to delete the topic
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Topic"),
          content: const Text("Are you sure you want to delete this topic?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text("Delete"),
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('boardCategories')
                      .doc(boardId)
                      .collection('topics')
                      .doc(topicId)
                      .delete();

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Topic deleted")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to delete topic")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
