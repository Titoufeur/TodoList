import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';

enum FormMode { add, edit }

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
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: _content,
            onSaved: (value) => _content = value!,
          ),
          // Other form fields here...
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
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (widget.formMode == FormMode.add) {
                  Provider.of<TasksProvider>(context, listen: false).addTask(
                    Task(
                      id: '', // Generate a unique ID
                      content: _content,
                      completed: false,
                      priority: _priority, userId: '', dueDate: DateTime(2024),
                    ),
                  );
                } else if (widget.formMode == FormMode.edit) {
                  Provider.of<TasksProvider>(context, listen: false).updateTask(
                    Task(
                      id: widget.task!.id,
                      content: _content,
                      completed: widget.task!.completed,
                      priority: _priority, userId: '', dueDate: DateTime(2024),
                    ),
                  );
                }
                Navigator.of(context).pop();
              }
            },
            child: Text(widget.formMode == FormMode.add ? 'Add Task' : 'Edit Task'),
          ),
        ],
      ),
    );
  }
}
