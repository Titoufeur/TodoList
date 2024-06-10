import 'package:flutter/material.dart';

class Master extends StatelessWidget {
  const Master({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      body: const Center(
        child: Text('Hello World!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Add my callback function here
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
