import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  final TaskService _taskService = TaskService();

//Met a jour les tâches et notifie les Consumers
  Future<void> fetchTasks() async {
    try {
      _tasks = await _taskService.fetchTasks();
      print('Tasks in provider: $_tasks');
      notifyListeners();
    } catch (e) {
      print('Failed to fetch tasks: $e');
    }
  }

  void addTask(Task task) async {
    await _taskService.createTask(task);
    notifyListeners();
  }

  void updateTask(Task updatedTask) async {
    await _taskService.updateTask(updatedTask);
    notifyListeners();
  }

  void removeTask(Task task) async {
    await _taskService.removeTask(task);
    notifyListeners();
  }
//Change l'état de complétion de la tache
  void completeTask(Task task) async {
    await _taskService.toggleTaskCompletion(task);
    notifyListeners();
  }
  //Trie par priorité
  List<Task> getTasksSortedByPriority() {
    List<Task> tasks = _taskService.tasks;
    tasks.sort((b, a) => a.priority.index.compareTo(b.priority.index));
    return tasks;
  }

  Task getTaskById(String id) {
    return _taskService.getTaskById(id);
  }

  List<Task> getTasks() {
    return _taskService.tasks;
  }
}
