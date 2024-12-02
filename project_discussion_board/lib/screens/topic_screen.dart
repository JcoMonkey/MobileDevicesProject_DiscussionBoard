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

  const TopicScreen({
    super.key,
    required this.boardId,
    required this.boardName,
  });

  @override
  State<TopicScreen> createState() => TopicScreenState();
}

class TopicScreenState extends State<TopicScreen> {
  String _searchQuery = '';

  /// Filters topics based on the search query.
  List<DocumentSnapshot> _filterTopics(
      List<DocumentSnapshot> topics, String query) {
    if (query.isEmpty) {
      return topics;
    }

    return topics.where((doc) {
      final title =
          (doc.data() as Map<String, dynamic>)['title']?.toLowerCase();
      return title != null && title.contains(query.toLowerCase());
    }).toList();
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
            // Search bar for filtering topics
            CustomSearchBar(
              onSearch: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('boardCategories')
                    .doc(widget.boardId)
                    .collection('topics')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error loading topics.'),
                    );
                  }

                  final topics =
                      _filterTopics(snapshot.data?.docs ?? [], _searchQuery);

                  if (topics.isEmpty) {
                    return const Center(child: Text('No topics available.'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      final data = topic.data() as Map<String, dynamic>;
                      return TopicCard(
                        topicId: topic.id,
                        topicTitle: data['title'],
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
              _addNewTopic(newTopic);
              final snackbar = SnackBar(
                content: const Text('Topic created'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // TODO: Add logic to undo the topic addition
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
        ),
      ),
    );
  }

  Future<void> _addNewTopic(String title) async {
    final topicData = {
      'title': title,
      'timestamp': FieldValue.serverTimestamp(), // To sort topics
    };

    await FirebaseFirestore.instance
        .collection('boardCategories')
        .doc(widget.boardId)
        .collection('topics')
        .add(topicData);
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
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop(_textController.text);
            }
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
