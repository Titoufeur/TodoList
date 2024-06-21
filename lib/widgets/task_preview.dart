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
    Color? backgroundColor;
    //Affiche le bg de la tâche différemment en fonction de son niveau de priorité
    if (!task.completed) {
      switch (task.priority) {
        case Priority.haute:
          backgroundColor = Colors.orange[300];
          break;
        case Priority.normale:
          backgroundColor = Colors.yellow[300];
          break;
        case Priority.basse:
          backgroundColor = Colors.blue[300];
          break;
        default:
          backgroundColor = Colors.grey[300];
          break;
      }
    }

    return Consumer<TasksProvider>(
      builder: (context, tasksProvider, child) {
        return Container(
          color: backgroundColor,
          child: ListTile(
            title: Text(task.content),
            leading: Icon(
              task.completed ? Icons.check_circle : Icons.circle,
              color: task.completed ? Colors.green : Colors.red,
            ),
            onTap: onTap,
            trailing: IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                tasksProvider.completeTask(task);
              },
            ),
          ),
        );
      },
    );
  }
}
