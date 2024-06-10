import 'package:flutter/material.dart';
import 'master.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Master(),
    );
  }
}
