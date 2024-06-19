import 'dart:async';
import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';

class TaskService {
  final faker = Faker();
  final uuid = const Uuid();
  List<Task> _tasks = [];

  TaskService() {
    _tasks = List.generate(
      10,
          (index) => Task(
        id: uuid.v4(),
        content: faker.lorem.sentences(3).join(' '),
        completed: faker.randomGenerator.boolean(),
      ),
    );
  }

  List<Task> get tasks => _tasks;

  List<Task> fetchTasks() {
    return tasks;
  }

  Future<void> createTask(Task newTask) async {
    _tasks.add(newTask);
  }

  void removeTask(Task task) {
    _tasks.remove(task);
  }

  void updateTask(Task updatedTask) {
    var index = _tasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  }

  Task getTaskById(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }
}
