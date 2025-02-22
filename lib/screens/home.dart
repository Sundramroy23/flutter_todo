import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/widgets/taskWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/todo.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const HomePage({super.key, required this.toggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyTodo> todoslist = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  void loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storedTodos = prefs.getStringList('todos');
    if (storedTodos != null) {
      todoslist = storedTodos
          .map((jsonTodo) => MyTodo.fromJson(jsonDecode(jsonTodo)))
          .toList();
    } else {
      todoslist = MyTodo.todos; // fallback if not yet saved
    }
    setState(() {});
  }

  void saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoJsonList = todoslist.map((t) => jsonEncode(t.toJson())).toList();
    prefs.setStringList('todos', todoJsonList);
  }

  void _showAlerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add a new task"),
          content: TextField(
            decoration: const InputDecoration(hintText: "Enter your task"),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  final newTodo = MyTodo(title: value, done: false);
                  todoslist.add(newTodo);
                  saveTodos();
                });
                Navigator.pop(context);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );
  }

  void _deleteTodoWithUndo(MyTodo todo) {
    // Find the item's index
    final int index = todoslist.indexWhere((t) => t.id == todo.id);
    if (index == -1) return;
    // Store a reference to the removed item
    final removedTodo = todoslist[index];

    // Remove the item and update local storage
    setState(() {
      todoslist.removeAt(index);
      saveTodos();
    });

    // Show a SnackBar with an Undo action for 3 seconds.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Reinsert the item back at its original index.
            setState(() {
              todoslist.insert(index, removedTodo);
              saveTodos();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter todos based on search query
    final filteredTodos = todoslist
        .where((todo) =>
            todo.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            SearchBox(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedTwenty(),
            Row(
              children: [
                const Text(
                  "My TODOs",
                  style: TextStyle(
                    color: tdBlack,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: _showAlerDialog,
                  icon: const Icon(Icons.add_circle, color: tdBlue, size: 30),
                )
              ],
            ),
            const SizedTwenty(),
            TodoListView(
              todoslist: filteredTodos,
              onDelete: (MyTodo todo) {
                _deleteTodoWithUndo(todo);
              },
            )
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: widget.toggleTheme,
          icon: const Icon(Icons.brightness_6),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CircleAvatar(
            child: const Icon(Icons.person),
          ),
        )
      ],
    );
  }
}

class TodoListView extends StatelessWidget {
  const TodoListView({
    super.key,
    required this.todoslist,
    required this.onDelete,
  });

  final List<MyTodo> todoslist;
  final Function(MyTodo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: todoslist.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).cardColor, // Use cardColor based on theme
              borderRadius: BorderRadius.circular(20),
            ),
            child: Taskwidget(
              todoslist[index],
              onDelete: () {
                onDelete(todoslist[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

class SizedTwenty extends StatelessWidget {
  const SizedTwenty({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBox({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: isDark ? Colors.white70 : tdBlack,
            size: 22,
          ),
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 22, minWidth: 25),
          contentPadding: const EdgeInsets.all(0),
          hintText: 'Search',
          hintStyle: TextStyle(
            color: isDark ? Colors.white54 : tdGrey,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
