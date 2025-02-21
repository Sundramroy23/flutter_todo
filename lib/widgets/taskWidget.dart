import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import '../model/todo.dart';

class Taskwidget extends StatelessWidget {
  const Taskwidget(this.todos, {super.key});

  final MyTodo todos;
  // final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Checkbox(value: todos.done, onChanged: null),
      title: Text(
        todos.title,
        style: TextStyle(fontSize: 16),
      ),
      trailing: Icon(
        Icons.delete,
        color: tdRed,
        size: 20,
      ),
    );
  }
}
