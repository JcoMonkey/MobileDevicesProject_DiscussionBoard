import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/search_bar.dart';
import '../widgets/topic_card.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'home_screen.dart';

/// TopicScreen displays a list of topics within a selected board.
/// Users can access this screen from the board or home screen.
class TopicScreen extends StatefulWidget {
  final String boardId;
  final String boardName;

  const TopicScreen(
      {super.key, required this.boardId, required this.boardName});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  /// Add a new topic to Firestore.
  Future<void> _addNewTopic(String title) async {
    final topicData = {
      'title': title,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance
        .collection('boardCategories')
        .doc(widget.boardId)
        .collection('topics')
        .add(topicData);
  }

  Stream<List<Map<String, dynamic>>> _fetchTopics() {
    return FirebaseFirestore.instance
        .collection('boardCategories')
        .doc(widget.boardId)
        .collection('topics')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return {
                'id': doc.id,
                'title': doc.data()['title'],
              };
            }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      rightScreen: const HomeScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.boardName),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Placeholder for additional options in the future
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const CustomSearchBar(), // Search bar
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: _fetchTopics(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading topics.'));
                  }

                  final topics = snapshot.data ?? [];
                  if (topics.isEmpty) {
                    return const Center(child: Text('No topics available.'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Display in 3 columns
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      return TopicCard(
                        topicId: topic['id'],
                        topicTitle: topic['title'],
                        boardId: widget.boardId,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            const TaskBar(currentIndex: 1), // TaskBar with 'Home' tab selected
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            String? newTopic = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddTopic();
              },
            );
            if (newTopic != null && newTopic.isNotEmpty) {
              _addNewTopic(newTopic); // Save to Firestore
              final snackbar = SnackBar(
                content: const Text('Topic created'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // TODO: Add logic to undo the topic addition
                  },
                ),
              );
              // Show the SnackBar
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
        ),
      ),
    );
  }
}

// Creates a dialog that allows the creation of a new topic.
class AddTopic extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  AddTopic({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Topic"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: "Title",
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a title";
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context)
                  .pop(_textController.text); // Return the text
            }
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
