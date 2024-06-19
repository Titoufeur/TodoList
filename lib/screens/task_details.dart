import 'package:flutter/material.dart';
import 'task_form.dart';
import '../models/task.dart';

class TaskDetails extends StatelessWidget {
  final FormMode formMode;
  final Task? task;

  const TaskDetails({Key? key, required this.formMode, this.task}) : super(key: key);
//Widget utilisé pour afficher les détails d'une tache afin de les modifier, ou alors pour ajouter une nouvelle tache.
  //Il affiche TaskForm, en lui disant dans quel mode il doit s'afficher : add ou edit.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formMode == FormMode.add ? 'Ajouter une tâche' : 'Modifier une tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskForm(formMode: formMode, task: task),
      ),
    );
  }
}
