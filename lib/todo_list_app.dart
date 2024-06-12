import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/tasks_master.dart';
import 'master.dart';

class ToDoListApp extends StatefulWidget {
  const ToDoListApp({super.key});

  @override
  State<ToDoListApp> createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TasksMaster(),
    );
  }
}