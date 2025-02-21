import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/widgets/taskWidget.dart';
import '../model/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyTodo> todoslist = [];

  @override
  void initState() {
    todoslist = MyTodo.todos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.blueGrey,
        child: Column(
          children: [
            SearchBox(),
            SizedTwenty(),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "My TODOs",
                style: TextStyle(
                  color: tdBlack,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedTwenty(),
            Expanded(
              child: ListView.builder(
                itemCount: todoslist.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Taskwidget(todoslist[index]),
                  );
                },
              ),
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
        icon: Icon(Icons.menu),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CircleAvatar(
            child: Icon(Icons.person),
          ),
        )
      ],
    );
  }
}

class SizedTwenty extends StatelessWidget {
  const SizedTwenty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      // height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 22,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 22, minWidth: 25),
          contentPadding: EdgeInsets.all(0),
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
