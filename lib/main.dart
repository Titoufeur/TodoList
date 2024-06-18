import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_list_app.dart';
import 'providers/tasks_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: const ToDoListApp(),
    ),
  );
}
