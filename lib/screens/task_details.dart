import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetails extends StatefulWidget {
  final Task task;

  const TaskDetails({required this.task, super.key});

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    contentController = TextEditingController(text: widget.task.content);
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              readOnly: true,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text('Completed: '),
                Icon(
                  widget.task.completed ? Icons.check_circle : Icons.circle,
                  color: widget.task.completed ? Colors.green : Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}
