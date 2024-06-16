import 'dart:async';
import 'package:faker/faker.dart';
import '../models/task.dart';

class TaskService {
  Future<List<Task>> fetchTasks() async {

    final faker = Faker();
    List<Task> tasks = List.generate(10, (index) {
      return Task(
        id: faker.guid.guid(),
        content: faker.lorem.sentence(),
        completed: faker.randomGenerator.boolean(),
      );
    });

    return tasks;
  }

  Future<void> createTask(Task newTask) async {
    List<Task> tasks = await fetchTasks();
    tasks.add(newTask);
  }
}
