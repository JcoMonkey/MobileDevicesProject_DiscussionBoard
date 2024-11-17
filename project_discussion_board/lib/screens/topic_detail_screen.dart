import 'package:flutter/material.dart';
import '../widgets/task_bar.dart';

/// TopicDetailScreen displays detailed information about a selected topic
/// and allows users to view and add comments. This screen includes the topic details,
/// a list of comments, and an input field for adding new comments.
class TopicDetailScreen extends StatefulWidget {
  final String topicTitle;

  TopicDetailScreen({required this.topicTitle});

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  final List<String> comments = []; //TODO: give each topic it's own "screen" using firebase
  final _commentController = TextEditingController();

  void _sendMessage() {
    if (_commentController.text.trim().isEmpty) return;

    setState(() {
      comments.add(_commentController.text);
    });
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.topicTitle),  // Display the title of the topic
      ),
      body: Column(
        children: [
          // Display the main content/details of the topic
          SizedBox(
            height: 120,
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                // Container for topic details
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[200],
                  child: Text(
                    'Details about ${widget.topicTitle}. This is where the main content of the topic will go.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                // Section heading for comments
                Text(
                  'Comments',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            //height: 200,
            child: ListView.builder(
              itemCount: comments.length,
              reverse: false, //Puts last message at the bottom
              itemBuilder:(context, index) {
                return CommentWidget(comment: comments[index]);
              },
          ),
        ),
          // Input field for adding new comments
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
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
                    _sendMessage();
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
      color: const Color.fromARGB(255, 190, 167, 194),
      child: Text(comment),
    );
  }
}
