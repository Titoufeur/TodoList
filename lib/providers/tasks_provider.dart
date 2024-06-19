import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TasksProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
//Met a jour les tâches et notifie les Consumers
  Future<void> fetchTasks() async {
    _taskService.fetchTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    _taskService.createTask(task);
    notifyListeners();
  }

  Future<void> updateTask(Task updatedTask) async {
    _taskService.updateTask(updatedTask);
    notifyListeners();
  }

  Future<void> removeTask(Task task) async {
    _taskService.removeTask(task);
    notifyListeners();
  }
//Change l'état de complétion de la tache
  Future<void> completeTask(Task task) async {
    task.completed = !task.completed;
    _taskService.updateTask(task);
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
