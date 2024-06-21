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
  final String baseUrl = dotenv.env['SUPABASE_URL']!;
  final String apiKey = dotenv.env['SUPABASE_ANON_KEY']!;

  TaskService() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers['Authorization'] = 'Bearer $apiKey';
    _dio.options.headers['apikey'] = apiKey;
  }

  Future<List<Task>> fetchTasks() async {
    try {
      final response = await _dio.get('/rest/v1/tasks');
      if (response.statusCode == 200) {
        List<Task> tasks = (response.data as List)
            .map((json) => Task.fromJson(json))
            .toList();
        return tasks;
      } else {
        throw Exception('Erreur lors du fetchTasks');
      }
    } catch (e) {
      print('Erreur lors du fetch des tâches: $e');
      throw e;
    }
  }

  Future<bool> createTask(Task newTask) async {
    try {
      print(newTask);
      await _dio.post('/rest/v1/tasks', data: newTask.toJson());
      return true;
    } catch (error) {
      print('Erreur lors de la création de la tâche: $error');
      rethrow;
    }
  }

  Future<bool> removeTask(Task task) async {
    try {
      await _dio.delete('/rest/v1/tasks?id=eq.${task.id}');
      return true;
    } catch (error) {
      print('Erreur lors de la suppression de la tache: $error');
      rethrow;
    }
  }

  Future<bool> updateTask(Task updatedTask) async {
    try {
      await _dio.patch('/rest/v1/tasks?id=eq.${updatedTask.id}', data: updatedTask.toJson());
      return true;
    } catch (error) {
      print('Erreur de taskService lors de la modif de la tache : $error');
      rethrow;
    }
  }

  Future<bool> toggleTaskCompletion(Task task) async {
    try {
      await _dio.patch(
        '/rest/v1/tasks?id=eq.${task.id}',
        data: {'completed': !task.completed},
      );
      return true;
    } catch (error) {
      print('Erreur lors de la complétion de la tâche: $error');
      rethrow;
    }
  }
}
