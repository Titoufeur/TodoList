import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';
import '../screens/task_form.dart';

class TaskDetails extends StatelessWidget {
  final Task task;

  const TaskDetails({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID de la tâche: ${task.id}'),
            const SizedBox(height: 8.0),
            Text('Contenu: ${task.content}'),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text('Complétée: '),
                Icon(
                  task.completed ? Icons.check_circle : Icons.circle,
                  color: task.completed ? Colors.green : Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _editTask(context);
              },
              child: const Text('Modifier la tâche'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }

  void _editTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => TaskForm(formMode: FormMode.Edit, task: task),
    ).then((editedTask) {
      if (editedTask != null) {
        Provider.of<TasksProvider>(context, listen: false).editTask(editedTask);
      }
    });
  }
}
