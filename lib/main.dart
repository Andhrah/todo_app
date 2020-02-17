import 'package:flutter/material.dart';
import 'package:todo_app/util/dbhelper.dart';
import './models/todo.dart';
import './screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todos',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: HomePage(title: 'Todos'),
    );
  }
}
