import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'todo_list_app.dart';
import 'providers/tasks_provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  print('SUPABASE_URL: ${dotenv.env['SUPABASE_URL']}');
  print('SUPABASE_ANON_KEY: ${dotenv.env['SUPABASE_ANON_KEY']}');
  print('API_KEY: ${dotenv.env['API_KEY']}');
  runApp(
    ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: const ToDoListApp(),
    ),
  );
}
