import 'dart:async';
import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';

class TaskService {
  final Dio _dio = Dio(
  BaseOptions(
  baseUrl: dotenv.env['SUPABASE_URL']!,
  headers: {
  'apikey': dotenv.env['SUPABASE_ANON_KEY']!,
  'Authorization': 'Bearer ${dotenv.env['SUPABASE_ANON_KEY']!}',
  'Content-Type': 'application/json',
  },
  ),
  );
  final faker = Faker();
  final uuid = const Uuid();
  List<Task> _tasks = [];
  final String baseUrl = dotenv.env['SUPABASE_URL']!;
  final String apiKey = dotenv.env['SUPABASE_ANON_KEY']!;

  TaskService() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers['Authorization'] = 'Bearer $apiKey';
    _dio.options.headers['apikey'] = apiKey;
  }

  List<Task> get tasks => _tasks;

  Future<List<Task>> fetchTasks() async {
    try {
      final response = await _dio.get('/rest/v1/tasks');
      if (response.statusCode == 200) {
        List<Task> tasks = (response.data as List)
            .map((json) => Task.fromJson(json))
            .toList();
        _tasks = tasks;
        return tasks;
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      print('Error fetching tasks: $e');
      throw e;
    }
  }




  Future<void> createTask(Task newTask) async {
    try {
      final response = await _dio.post('/rest/v1/tasks', data: newTask.toJson());

      if (response.statusCode == 201) {
        _tasks.add(Task.fromJson(response.data));
      } else {
        throw Exception('Failed to create task');
      }
    } catch (error) {
      print('Error creating task: $error');
      rethrow;
    }
  }

  Future<void> removeTask(Task task) async {
    try {
      final response = await _dio.delete('/rest/v1/tasks?id=eq.${task.id}');

      if (response.statusCode == 200) {
        _tasks.removeWhere((t) => t.id == task.id);
      } else {
        throw Exception('Failed to delete task');
      }
    } catch (error) {
      print('Error deleting task: $error');
      rethrow;
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      final response = await _dio.patch('/rest/v1/tasks?id=eq.${updatedTask.id}', data: updatedTask.toJson());

      if (response.statusCode == 200) {
        var index = _tasks.indexWhere((t) => t.id == updatedTask.id);
        if (index != -1) {
          _tasks[index] = Task.fromJson(response.data);
        }
      } else {
        throw Exception('Failed to update task');
      }
    } catch (error) {
      print('Error updating task: $error');
      rethrow;
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    task.completed = !task.completed;
    await updateTask(task);
  }

  Task getTaskById(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }
}
