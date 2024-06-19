import 'package:uuid/uuid.dart';
import 'tag.dart';

var uuid = const Uuid();

enum Priority { basse, normale, haute }

class Task {
  String id;
  String userId;
  String content;
  List<Tag> tags;
  bool completed;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime dueDate;
  Priority priority;

  Task({
    String? id,
    String? userId,
    required this.content,
    List<Tag>? tags,
    this.completed = false,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? dueDate,
    this.priority = Priority.normale,
  })  : id = id ?? uuid.v4(),
        userId = userId ?? uuid.v4(),
        tags = tags ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        dueDate = dueDate ?? DateTime.now().add(const Duration(days: 7));


  @override
  String toString() {
    return 'Task(id: $id, content: $content, completed: $completed, priority: $priority, tags: ${tags.length})';
  }
}
