import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Task{
  String? id;
  String content;
  bool completed;
  String? title;

  Task({ required this.content, String? pTitle, String? pid}):completed=false,id=uuid.v4(){
    id= pid ??id;
  }

  @override
  String toString() {
    return "Task(content:$content, id:$id)";
  }
}