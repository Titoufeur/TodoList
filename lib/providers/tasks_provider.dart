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
      notifyListeners();
    } catch (e) {
      print('Failed to fetch tasks: $e');
    }
  }
//Ajoute une tache. Appelle la methode createTask, et si réussite, l'ajoute à sa liste de taches.
  void addTask(Task task) async {
    try {
      bool response = await _taskService.createTask(task);
      if (response){
        _tasks.add(task);
        notifyListeners();
      } else{
        print('Erreur lors de l\'ajout de la tache $task');
      }
    } catch (e) {
      print('Erreur lors de l\'ajout de la tache $e');
    }
  }
//Même mécanisme
  void updateTask(Task updatedTask) async {
    try {
      if (await _taskService.updateTask(updatedTask)){
        int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
        if (index != -1) {
          _tasks[index] = updatedTask;
          notifyListeners();
        }
      }
    } catch (e) {
      print('erreur lors de la modification de la tache: $e');
    }
  }
//Même mécanisme
  void removeTask(Task task) async {
    try {
      if (await _taskService.removeTask(task)){
        _tasks.removeWhere((t) => t.id == task.id);
        notifyListeners();
      }
    } catch (e) {
      print('erreur lors de la suppression de la tache : $e');
    }
  }
//Change l'état de complétion de la tache. Même mécanisme
  void completeTask(Task task) async {
    try {
      if (await _taskService.toggleTaskCompletion(task)){
        int index = _tasks.indexWhere((t) => t.id == task.id);
        if (index != -1) {
          _tasks[index].completed = !_tasks[index].completed;
          notifyListeners();
        }
      }
    } catch (e) {
      print('Erreur lors du toggle de la tache: $e');
    }
  }
  //Trie par priorité
  List<Task> getTasksSortedByPriority() {
    List<Task> sortedTasks = List.from(_tasks);
    sortedTasks.sort((b, a) => a.priority.index.compareTo(b.priority.index));
    return sortedTasks;
  }

  Task getTaskById(String id) {
    return _tasks.firstWhere((task) => task.id == id, orElse: () => throw Exception('Tache non trouvée'));
  }

  List<Task> getTasks() {
    return _tasks;
  }
}
