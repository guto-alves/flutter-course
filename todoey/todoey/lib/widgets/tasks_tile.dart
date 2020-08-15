import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile(
      {@required this.name,
      @required this.isChecked,
      this.onChanged,
      this.onLongPress});

  final String name;
  final bool isChecked;
  final Function onChanged;
  final Function onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(
            decoration:
                isChecked ? TextDecoration.lineThrough : TextDecoration.none),
      ),
      trailing: Checkbox(
        value: isChecked,
        onChanged: onChanged,
      ),
      onLongPress: onLongPress,
    );
  }
}
