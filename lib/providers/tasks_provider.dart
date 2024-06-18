import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TasksProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _taskService.fetchTasks();
  }

  void addTask(Task task) {
    _taskService.createTask(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _taskService.removeTask(task);
    notifyListeners();
  }

  void toggleTaskCompletion(Task task) {
    task.completed = !task.completed;
    _taskService.updateTask(task);
    notifyListeners();
  }

  Task getTaskById(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }
}
