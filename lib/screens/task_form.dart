import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  bool _completed = false;

  void _submitForm() async {//Méthode appelée lorsqu'on submit le form
    if (_formKey.currentState!.validate()) {
      Task newTask = Task(//Crée une tache avec les informations fournies
        content: _contentController.text,
        completed: _completed,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task created successfully')),
      );
      Navigator.of(context).pop(newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: const Text('Completed'),
                value: _completed,
                onChanged: (bool? value) {
                  setState(() {
                    _completed = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Create Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
