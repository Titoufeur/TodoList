import 'package:todolist/models/user.dart';

enum Priority { basse, normale, haute }

class Task {
  final String id;
  final String userId;
  final String content;
  final DateTime dueDate;
  final Priority priority;
  late bool completed;

  Task({
    String? id,
    String? user_id,
    required this.content,
    required this.dueDate,
    required this.priority,
    this.completed = false,
  })  : id = id ?? uuid.v4(),
        userId = user_id ?? uuid.v4();

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      user_id: json['user_id'] as String,
      content: json['content'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      priority: Priority.values.firstWhere((e) => e.toString().split('.').last == json['priority']),
      completed: json['completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'content': content,
      'priority': priority.toString().split('.').last,
      'dueDate': dueDate.toIso8601String(),
      'completed': completed,
    };
  }

  @override
  String toString() {
    return 'Task(id: $id, content: $content, completed: $completed, priority: $priority';
  }
}
