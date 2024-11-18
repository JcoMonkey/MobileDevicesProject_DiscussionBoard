import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/topic_card.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'home_screen.dart';

/// TopicScreen displays a list of topics within a selected board.
/// Users can access this screen from the board or home screen.
/// This screen includes a search bar, a grid of topic cards, and the task bar at the bottom.
class TopicScreen extends StatefulWidget {
  
  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  List<String> topicList = ['Topic 1', 'Topic 2', 'Topic 3'];

  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      rightScreen: HomeScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Topics'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Placeholder for additional options in the future
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Search bar for filtering topics
            CustomSearchBar(),
            // GridView showing list of topic cards
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,  // Display in 3 columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: topicList.length, // Placeholder count for topics
                itemBuilder: (context, index) {
                  return TopicCard(topicTitle: topicList[index]);
                },
              ),
            ),
          ],
        ),
        // TaskBar with 'Home' tab selected
        bottomNavigationBar: TaskBar(currentIndex: 1),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            String newTopic = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddTopic();
              },
            );
            setState(() {
              topicList.add(newTopic);  
            });
            final snackbar = SnackBar(
              content: Text('Topic created'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // TODO: Undo the action when the user taps 'Undo' 
                  print('Undo action');
                },
              ),
            );
            // Show the SnackBar
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        ),
      ),
    );
  }
}

// Creates a dialog that allows the creation of a new topic
class AddTopic extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  AddTopic({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Topic"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _textController,
          decoration: InputDecoration(
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
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop(_textController.text); // Return the text
            }
          },
          child: Text("Submit"),
        ),
      ],
    );
  }
}