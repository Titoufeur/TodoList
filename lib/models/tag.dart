class Tag {
  int id;
  String value;
  String userId;
  List<String> taskIds;

  Tag({
    required this.id,
    required this.value,
    required this.userId,
    List<String>? taskIds,
  }) : taskIds = taskIds ?? [];

  @override
  String toString() {
    return 'Tag(id: $id, value: $value, userId: $userId, taskIds: ${taskIds.length})';
  }
}
