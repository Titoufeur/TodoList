import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';

enum FormMode { add, edit }

//Formulaire affiché pour la création / modification de tâches.
class TaskForm extends StatefulWidget {
  final FormMode formMode;
  final Task? task;

  const TaskForm({required this.formMode, this.task, Key? key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late String _content;
  late DateTime _dueDate;
  late Priority _priority;

  @override
  void initState() {
    super.initState();
    _content = widget.task?.content ?? '';
    _priority = widget.task?.priority ?? Priority.normale;
    _dueDate = widget.task?.dueDate ?? DateTime.now();
  }
  //sélecteur pour sélectionner une date de rendu de la tache
  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
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
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //Formulaire pour rentrer le contenu de la tâche. Si on est en mode édition et donc que la tâche a déjà du contenu, on l'affiche dans le formulaire
          TextFormField(
            initialValue: _content,
            decoration: const InputDecoration(labelText: 'ContenuDecoration'),
            onSaved: (value) => _content = value!,
          ),
          //élément pour sélectionner la date de rendu
          ListTile(
            title: Text("Deadline : ${_dueDate.toLocal()}".split(' ')[0]),
            trailing: const Icon(Icons.keyboard_arrow_down),
            onTap: () => _selectDueDate(context),
          ),
          //Liste dropdown pour sélectionner la priorité de la tâche
          DropdownButtonFormField<Priority>(
            value: _priority,
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
            onSaved: (value) => _priority = value!,
          ),
          //Bouton 'submit', soit pour ajouter la tâche (crée un objet tâche en conséquence avec les infos des formulaires)
          //Ou soit pour modifier la tâche (Re crée un objet tâche à partir du formulaire)
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (widget.formMode == FormMode.add) {
                  //Si on est en mode ajout, on appelle la méthode addTask
                  Provider.of<TasksProvider>(context, listen: false).addTask(
                    Task(
                      content: _content,
                      priority: _priority,
                      dueDate: _dueDate,
                    ),
                  );
                } else if (widget.formMode == FormMode.edit) {
                  //Sinon, on appelle la méthode update Task
                  Provider.of<TasksProvider>(context, listen: false).updateTask(
                    Task(
                      id: widget.task!.id,
                      content: _content,
                      completed: widget.task!.completed,
                      priority: _priority,
                      dueDate: _dueDate,
                    ),
                  );
                }
                Navigator.of(context).pop();
              }
            },
            child: Text(widget.formMode == FormMode.add ? 'Ajouter une tâche' : 'Enregistrer les modifications'),
          ),
          if (widget.formMode == FormMode.edit)
            //Si on est en mode édit, on affiche un bouton pour supprimer la tâche
            ElevatedButton(
              onPressed: () {
                Provider.of<TasksProvider>(context, listen: false).removeTask(widget.task!);
                Navigator.of(context).pop();
              },
              child: const Text('Supprimer la tâche'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[100]),
            ),
        ],
      ),
    );
  }
}
