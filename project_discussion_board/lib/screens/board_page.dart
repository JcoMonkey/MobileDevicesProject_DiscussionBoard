/*
todo:
-add navigation to topic page
-list of topics
*/

import 'package:flutter/material.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key, required this.title});

  final String title;

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              print("More button pressed");
            },
          ),
        ]
    ));

  }
}