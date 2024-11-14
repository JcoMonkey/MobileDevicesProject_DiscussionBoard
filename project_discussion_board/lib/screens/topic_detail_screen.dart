import 'package:flutter/material.dart';
import '../widgets/task_bar.dart';

/// TopicDetailScreen displays detailed information about a selected topic
/// and allows users to view and add comments. This screen includes the topic details,
/// a list of comments, and an input field for adding new comments.
class TopicDetailScreen extends StatelessWidget {
  final String topicTitle;

  // Constructor to accept the topic title
  TopicDetailScreen({required this.topicTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topicTitle),  // Display the title of the topic
      ),
      body: Column(
        children: [
          // Display the main content/details of the topic
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                // Container for topic details
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[200],
                  child: Text(
                    'Details about $topicTitle. This is where the main content of the topic will go.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                // Section heading for comments
                Text(
                  'Comments',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                // Placeholder comments
                CommentWidget(comment: 'This is a comment.'),
                CommentWidget(comment: 'Another comment goes here.'),
              ],
            ),
          ),
          // Input field for adding new comments
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Placeholder for sending a comment
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // Optional TaskBar at the bottom (adjust as needed)
      bottomNavigationBar: TaskBar(currentIndex: 1), // Example index
    );
  }
}

/// A simple widget to represent each comment in the list
class CommentWidget extends StatelessWidget {
  final String comment;

  CommentWidget({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[100],
      child: Text(comment),
    );
  }
}
