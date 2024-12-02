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
        _showOptionsDialog(context);
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

  /// Displays a dialog for edit & delete options
  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Edit"),
                onTap: () {
                  Navigator.pop(context);
                  _showEditDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("Delete"),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteDialog(context);
                },
              ),
            ],
          ),
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
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
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
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  /// Dislays dialog to edit the topic
  void _showEditDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    controller.text = topicTitle;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Topic"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final newTitle = controller.text.trim();
                if (newTitle.isNotEmpty) {
                  try {
                    await FirebaseFirestore.instance
                        .collection('boardCategories')
                        .doc(boardId)
                        .collection('topics')
                        .doc(topicId)
                        .update({'title': newTitle});

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Topic updated")),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to update topic")),
                    );
                  }
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
