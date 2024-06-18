import 'package:flutter/material.dart';
import '../models/task.dart';

enum FormMode { Add, Edit }

class TaskForm extends StatelessWidget {
  final FormMode formMode;
  final Task? task;

  const TaskForm({Key? key, required this.formMode, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController contentController =
    TextEditingController(text: task?.content ?? '');

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              formMode == FormMode.Add ? 'Ajouter une tâche' : 'Modifier la tâche',
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Contenu de la tâche'),
            ),
            if (formMode == FormMode.Edit) ...[
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Text('Complétée: '),
                  Checkbox(
                    value: task?.completed ?? false,
                    onChanged: (value) {
                      // Implement task completion toggle logic if needed
                    },
                  ),
                ],
              ),
            ],
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
                Task editedTask = task ?? Task(content: ''); // Initialize a new task if null
                editedTask.content = contentController.text;
                Navigator.of(context).pop(editedTask);
              },
              child: Text(formMode == FormMode.Add ? 'Ajouter' : 'Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
