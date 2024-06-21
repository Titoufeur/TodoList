import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';
import '../widgets/task_preview.dart';
import 'task_details.dart';
import 'task_form.dart';

class TasksMaster extends StatefulWidget {
  const TasksMaster({Key? key}) : super(key: key);

  @override
  _TasksMasterState createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  late Future<void> _fetchTasksFuture;

  @override
  void initState() {
    super.initState();
    _fetchTasksFuture = Provider.of<TasksProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: FutureBuilder(
        future: _fetchTasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<TasksProvider>(
              builder: (context, tasksProvider, child) {
                List<Task> sortedTasks = tasksProvider.getTasksSortedByPriority();
                return ListView.builder(
                  itemCount: sortedTasks.length,
                  itemBuilder: (context, index) {
                    final task = sortedTasks[index];
                    return TaskPreview(
                      task: task,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                //Affiche le formulaire en mode édition
                                child: TaskDetails(task: task, formMode: FormMode.edit,),
                              ),
                            );
                          },
                        ).then((newTask) {
                          if (newTask != null) {
                            Provider.of<TasksProvider>(context, listen: false)
                                .updateTask(newTask);
                          }
                        });
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  //Ici, ajoute le formulaire en mode ajout.
                  child: TaskForm(formMode: FormMode.add),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
