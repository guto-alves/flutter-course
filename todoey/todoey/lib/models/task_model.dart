import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'task.dart';

class TaskModel extends ChangeNotifier {
  final List<Task> _tasks = [];

  UnmodifiableListView get tasks => UnmodifiableListView(_tasks);

  int get totalTasks => _tasks.length;

  bool addTask(String taskName) {
    if (taskName.trim().isEmpty) {
      return false;
    }

    _tasks.add(Task(taskName));
    notifyListeners();
    return true;
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void toggleDone(Task task) {
    task.toggleDone();
    notifyListeners();
  }
}
