import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import '../model/todo.dart';

class Taskwidget extends StatefulWidget {
  const Taskwidget(
    this.todos, {
    super.key,
    required this.onDelete,
    required this.onToggle,
  });

  final MyTodo todos;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  @override
  State<Taskwidget> createState() => _TaskwidgetState();
}

class _TaskwidgetState extends State<Taskwidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Checkbox(
        value: widget.todos.done,
        onChanged: (bool? value) {
          setState(() {
            widget.todos.done = value!;
          });
          // Notify parent to update shared preferences
          widget.onToggle();
        },
      ),
      title: Text(
        widget.todos.title,
        style: TextStyle(
          fontSize: 16,
          color: theme.textTheme.bodyLarge?.color,
          decoration: widget.todos.done
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      trailing: IconButton(
        onPressed: widget.onDelete,
        icon: Icon(Icons.delete),
        color: tdRed,
        iconSize: 20,
      ),
    );
  }
}
