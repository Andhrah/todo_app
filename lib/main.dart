import 'package:flutter/material.dart';
import 'package:todo_app/util/dbhelper.dart';
import './models/todo.dart';
import './screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    List<Todo> todos = List<Todo>();
    DbHelper helper = DbHelper();
    helper.initializeDb().then(
      (result) => helper.getTodos().then((result) =>todos=result)
    );
    DateTime today = DateTime.now();
    Todo todo = Todo('Chat with friends', 1, today.toString(), 'Chat shouldnt exceed 30mins');
    var result = helper.insertTodo(todo);

    return MaterialApp(
      title: 'Todos',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: HomePage(title: 'Todos'),
    );
  }
}
