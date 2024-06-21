enum Priority { basse, normale, haute }

class Task {
  final String id;
  final String userId;
  final String content;
  final DateTime dueDate;
  final Priority priority;
  late final bool completed;

  Task({
    required this.id,
    required this.userId,
    required this.content,
    required this.dueDate,
    required this.priority,
    this.completed = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      content: json['content'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      priority: Priority.values.firstWhere((e) => e.toString() == 'Priority.' + (json['priority'] ?? 'normale')),
      completed: json['completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'content': content,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority.toString().split('.').last,
      'completed': completed,
    };
  }

  @override
  String toString() {
    return 'Task(id: $id, content: $content, completed: $completed, priority: $priority';
  }
}
