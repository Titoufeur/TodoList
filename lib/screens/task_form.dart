import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';

enum FormMode { add, edit }

class TaskForm extends StatefulWidget {
  final Task? task; // Tâche existante à modifier
  final FormMode formMode;//Mode d'affichage

  const TaskForm({Key? key, this.task, required this.formMode}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late String _content;
  late bool _completed;
  late DateTime _dueDate;
  late Priority _priority;

  @override
  void initState() {
    super.initState();
    // Si la tâche contient déjà des valeurs, on initialise les formulaires pour ne pas avoir à re rentrer toutes les infos
    // dès qu'on modifie la tâche.
    _content = widget.task?.content ?? '';
    _completed = widget.task?.completed ?? false;
    _dueDate = widget.task?.dueDate ?? DateTime.now().add(const Duration(days: 7));
    _priority = widget.task?.priority ?? Priority.normale;
  }
  //Fonction qui s'éxécute lorsqu'on modifie le formulaire
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (widget.formMode == FormMode.add) {
        //Si c'est en mode add, on utilise addTasks du provider pour ajouter la tache en la créant depuis les infos du formulaire.
        Provider.of<TasksProvider>(context, listen: false).addTask(Task(
          content: _content,
          completed: _completed,
          dueDate: _dueDate,
          priority: _priority,
        ));
        //Si c'est en mode edit, on appelle updateTasks avec les infos mises à jour.
      } else if (widget.formMode == FormMode.edit) {
        Task updatedTask = Task(
          id: widget.task!.id,
          userId: widget.task!.userId,
          content: _content,
          completed: _completed,
          dueDate: _dueDate,
          priority: _priority,
          createdAt: widget.task!.createdAt,
          updatedAt: DateTime.now(),
        );
        Provider.of<TasksProvider>(context, listen: false).updateTask(updatedTask);
      }
      //Et ça c'est pour fermer la fenêtre
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _content,
              decoration: const InputDecoration(labelText: 'Contenu'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrez le contenu de la tâche';
                }
                return null;
              },
              onSaved: (value) {
                _content = value!;
              },
            ),
            //Switch pour compléter ou non la tâche
            SwitchListTile(
              title: const Text('Complétée'),
              value: _completed,
              onChanged: (value) {
                setState(() {
                  _completed = value;
                });
              },
            ),
            //ListTile pour gérer la date
            ListTile(
              title: const Text('Date limite'),
              subtitle: Text(_dueDate.toLocal().toString().split(' ')[0]),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _dueDate) {
                    setState(() {
                      _dueDate = picked;
                    });
                  }
                },
              ),
            ),
            //DropDown qui gère la sélection de la priorité
            DropdownButtonFormField<Priority>(
              value: _priority,
              decoration: const InputDecoration(labelText: 'Priorité'),
              items: Priority.values.map((Priority priority) {
                return DropdownMenuItem<Priority>(
                  value: priority,
                  child: Text(priority.toString().split('.').last),
                );
              }).toList(),
              onChanged: (Priority? newValue) {
                setState(() {
                  _priority = newValue!;
                });
              },
              onSaved: (value) {
                _priority = value!;
              },
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(widget.formMode == FormMode.add ? 'Ajouter la tâche' : 'Enregistrer les modifications'),
            ),
          ],
        ),
      ),
    );
  }
}
