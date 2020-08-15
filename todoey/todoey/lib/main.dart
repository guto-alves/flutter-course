import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_model.dart';

import 'screens/tasks_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TaskModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TasksScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
