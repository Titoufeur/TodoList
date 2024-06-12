import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskPreview extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  const TaskPreview({required this.task, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.content),
      leading: Icon(
        task.completed ? Icons.check_circle : Icons.circle,
        color: task.completed ? Colors.green : Colors.red,
      ),
      onTap: onTap,
    );
  }
}
