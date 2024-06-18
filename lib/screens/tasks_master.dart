import 'package:flutter/material.dart';
import 'package:todolist/screens/task_form.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../widgets/task_preview.dart';
import 'task_details.dart';

class TasksMaster extends StatefulWidget {
  const TasksMaster({super.key});

  @override
  _TasksMasterState createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  final TaskService _taskService = TaskService();
  late Future<List<Task>> futureTasks;

  @override
  void initState() {//Initialise la liste de taches futureTasks en appelant la méthode fetchTasks()
    super.initState();
    futureTasks = _taskService.fetchTasks();
  }

  void _addTask(Task taskData) {//Ajoute une tâche à taskService, puis refresh sa liste de tâches en rappelant fetchTasks
    _taskService.createTask(taskData);
    setState(() {
      futureTasks = _taskService.fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: FutureBuilder<List<Task>>(
        future: futureTasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Task task = snapshot.data![index];
                return TaskPreview(task: task, onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetails(task: task),
                    ),
                  );
                });
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskForm()),
          ).then((newTask) {//Attends que l'utilisateur revienne sur la page en recevant l'objet newTask renvoyé par Navigator
            if (newTask != null) {
              _addTask(newTask);//Et ensuite ajoute la tache si elle existe
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
