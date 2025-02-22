import 'dart:convert';

class MyTodo {
  String id;
  String title;
  bool done;

  MyTodo({required this.title, required this.done})
      : id = DateTime.now().toString();

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'done': done};
  }

  factory MyTodo.fromJson(Map<String, dynamic> json) {
    var todo = MyTodo(title: json['title'], done: json['done']);
    todo.id = json['id'];
    return todo;
  }

  // You may remove these static methods if you start using local storage exclusively.
  static List<MyTodo> todos = [
    MyTodo(title: "Learn Flutter", done: false),
    MyTodo(title: "Learn Dart", done: false),
    MyTodo(title: "Improve skills", done: false),
    MyTodo(title: "Eat something", done: true),
  ];

  static void addTodo(String title) {
    todos.add(MyTodo(title: title, done: false));
  }

  static void deleteTodo(String id) {
    todos.removeWhere((element) => element.id == id);
  }
}
