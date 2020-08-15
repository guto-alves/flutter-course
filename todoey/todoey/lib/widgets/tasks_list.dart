import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_model.dart';

import 'tasks_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(
      builder: (context, taskModel, child) => ListView.builder(
        itemCount: taskModel.totalTasks,
        itemBuilder: (context, index) {
          var task = taskModel.tasks[index];

          return TaskTile(
            name: task.name,
            isChecked: task.isDone,
            onChanged: (value) => taskModel.toggleDone(task),
            onLongPress: () => taskModel.removeTask(index),
          );
        },
      ),
    );
  }
}
