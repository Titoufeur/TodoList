import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';

class TaskPreview extends StatelessWidget {
  final Task task;

  final VoidCallback onTap;

  const TaskPreview({required this.task, Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
      builder: (context, tasksProvider, child) {
        return ListTile(
          title: Text(task.content),
          leading: Icon(
            task.completed ? Icons.check_circle : Icons.circle,
            color: task.completed ? Colors.green : Colors.red,
          ),
          onTap: () {
            // ici il faut faire en sorte que la tâche passe en completed
            // !! TO DO !!
          },
        );
      },
    );
  }
}
