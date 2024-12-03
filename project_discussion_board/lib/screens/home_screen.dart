import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/search_bar.dart';
import '../widgets/board_card.dart';
import '../widgets/task_bar.dart';
import '../widgets/swipe_navigator.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'topic_screen.dart';
import 'topic_detail_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/theme_provider.dart';



/// HomeScreen is the main screen displaying a list of boards.
/// Users can access this screen from any other screen by selecting "Home" in the task bar.
/// This screen includes a search bar, a grid of board cards, and the task bar at the bottom.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late List<BoardCard> boardList = [];
  late List<Map<String, dynamic>> topicList = [];
  late List<dynamic> filteredList = [];
  bool isSearching = false;

  Future<void> getBoards() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('boardCategories').get();

    setState(() {
      boardList = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return BoardCard(
          boardId: doc.id,
          boardName: data['boardName'],
          boardImageURL: data['imageURL'],
        );
      }).toList();

      filteredList = boardList;
    });
  }

  Future<void> getTopics() async {
    final QuerySnapshot boardSnapshot =
        await FirebaseFirestore.instance.collection('boardCategories').get();

    List<Map<String, dynamic>> topics = [];
    for (var boardDoc in boardSnapshot.docs) {
      final boardId = boardDoc.id;
      final QuerySnapshot topicSnapshot = await boardDoc.reference
          .collection('topics')
          .orderBy('timestamp', descending: true)
          .get();

      for (var topicDoc in topicSnapshot.docs) {
        final topicData = topicDoc.data() as Map<String, dynamic>;
        topics.add({
          'id': topicDoc.id,
          'boardId': boardId,
          'title': topicData['title'],
        });
      }
    }

    setState(() {
      topicList = topics;
    });
  }

  /// Filter topics based on the search query
  void _filterResults(String query) {
    setState(() {
      if (query.isEmpty) {
        isSearching = false;
        filteredList = boardList;
      } else {
        isSearching = true;
        filteredList = topicList
            .where((topic) =>
                topic['title'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getBoards();
    getTopics();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeNavigator(
      leftScreen: const FavoritesScreen(),
      rightScreen: const ProfileScreen(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('HyperBoards'),
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
            CustomSearchBar(onSearch: _filterResults),
            Expanded(
              child: isSearching ? _buildTopicResults() : _buildBoardGrid(),
            ),
          ],
        ),
        // TaskBar with 'Home' tab selected
        bottomNavigationBar: const TaskBar(currentIndex: 1),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TopicScreen(
                  boardId: "board_id_here",
                  boardName: "board_name_here",
                ),
              ),
            ).then((_) {
              getTopics();
            });
          },
        ),
      ),
    );
  }

  /// Build the GridView for the boards
  Widget _buildBoardGrid() {
    if (boardList.isEmpty) {
      return const Center(child: Text('No boards available.'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: boardList.length,
      itemBuilder: (context, index) {
        return boardList[index];
      },
    );
  }

  /// Build the GridView for the topics
  Widget _buildTopicResults() {
    if (filteredList.isEmpty) {
      return const Center(child: Text('No topics found.'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final topic = filteredList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopicDetailScreen(
                  topicTitle: topic['title'],
                ),
              ),
            );
          },
          child: Container(
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.image, size: 80, color: Colors.grey),
                const SizedBox(height: 8),
                Text(topic['title']),
              ],
            ),
          ),
        );
      },
    );
  }
}
