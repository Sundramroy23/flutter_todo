class MyTodo {
  String id;
  String title;
  bool done;
  MyTodo({required this.title, required this.done})
      : id = DateTime.now().toString();

  static List<MyTodo> todos = [
    MyTodo(title: "Learn Flutter", done: false),
    MyTodo(title: "Learn Dart", done: false),
    MyTodo(title: "Improve skills", done: false),
    MyTodo(title: "Eat something", done: true),
  ];
}
