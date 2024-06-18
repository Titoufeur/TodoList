import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tasks_provider.dart';
import '../widgets/task_preview.dart';
import 'task_details.dart';
import 'task_form.dart';

class TasksMaster extends StatelessWidget {
  const TasksMaster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Consumer<TasksProvider>(
        builder: (context, tasksProvider, child) {
          return FutureBuilder(
            future: tasksProvider.fetchTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return ListView.builder(
                  itemCount: tasksProvider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasksProvider.tasks[index];
                    return TaskPreview(
                      task: task,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetails(task: task),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskForm()),
          );
          if (newTask != null) {
            Provider.of<TasksProvider>(context, listen: false).addTask(newTask);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
