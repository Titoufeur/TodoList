import 'package:uuid/uuid.dart';
import 'task.dart';

var uuid = const Uuid();

class User {
  String id;
  String firstname;
  String lastname;
  String email;
  String password;
  List<Task> tasks;

  User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    List<Task>? tasks,
    String? id,
  })  : id = id ?? uuid.v4(),
        tasks = tasks ?? [];

  @override
  String toString() {
    return 'User(id: $id, firstname: $firstname, lastname: $lastname, email: $email, tasks: ${tasks.length})';
  }
}
