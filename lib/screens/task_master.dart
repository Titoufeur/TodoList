import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskMaster extends StatefulWidget {
  const TaskMaster({super.key});

  @override
  State<TaskMaster> createState() => _TaskMasterState();
}

class _TaskMasterState extends State<TaskMaster> {
  Future<List<Task>> _fetchTasks() async {
    await Future.delayed(const Duration(seconds: 2));

    var faker = Faker();
    return List.generate(100, (index) {
      return Task(
        content: faker.lorem.sentence(),
        pTitle: faker.lorem.sentence(),
        pcompleted: faker.randomGenerator.boolean()
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(//Peut-être regarde si ya besoin de le remettre ou pas vu qu'il est déjà autre part
      appBar: AppBar(
        title: const Text('Task Master'),
      ),
      body: FutureBuilder<List<Task>>(
        future: _fetchTasks(),
        builder: (context, snapshot) {//Fonction appelée à chaque fois que l'état 'future' change
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());//Si il est en waiting, ça affiche un truc de chargement.
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));//SI ya une erreur, affiche le message d'erreur.
          } else if(!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks found.'));//Si le bordel est vide, ça le signale en disant qu'il n'y a pas de tâches qui ont été trouvées.
          } else{
            return ListView.builder(//Par contre si ya pas de chargement, pas d'erreur, et des données :
              itemCount: snapshot.data!.length,//On met un ListView avec x items,
              itemBuilder: (context, index) {//et poru chaque, on construit la tache
                return TaskPreview(task: snapshot.data![index]);//Grace au TaskPreview
              },
            );
          }
        },
      ),
    );
  }
}

class TaskPreview extends StatelessWidget {
  final Task task;

  const TaskPreview({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(//Construit une tile avec la task
      title: Text(task.title ?? 'No title'),//si ya pas de titre, affiche No title (normalement ya tjrs un titre mais Android Studio me force a mettre ça)
      subtitle: Text(task.content),
      leading: Icon(//Icone de la tache
        task.completed ? Icons.check_circle : Icons.circle,//Rond vert si elle est complete, rouge sinon.
        color: task.completed ? Colors.green : Colors.red,
      ),
    );
  }
}
