import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../util/dbhelper.dart';
import 'package:intl/intl.dart';

/// TodoDetail class
/// 
/// This class extends a stateful widget. It contains todo
/// property.
class TodoDetail extends StatefulWidget {
  final Todo todo;
  TodoDetail(this.todo);

  @override
  State<StatefulWidget> createState() => TodoDetailState(todo);
}

/// TodoDetailState class
/// 
/// This class extends state. It contains todo
/// property.
class TodoDetailState extends State {
  Todo todo;
  TodoDetailState(this.todo);
  /// `_priorities` is an array that contains the values of the priority
  final _priorities = ['High', 'Medium', 'Low'];
  String _priority = 'Low';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // return user interface which is a scaffold
    return Scaffold(
      appBar: AppBar(
        // diabled the back button
        automaticallyImplyLeading: false,
        title: Text(todo.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: titleController,
            style: textStyle,
            decoration: InputDecoration(
              labelText: 'Title',
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
              ),
            ),
          ),
          TextField(
            controller: descriptionController,
            style: textStyle,
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
              ),
            ),
          ),
          // dropdownbutton for the priority.
          // It contains string for the three priority level we want to use
          DropdownButton<String>(
            items: _priorities.map((String value) {
              return DropdownMenuItem<String> (
                value: value,
                child: Text(value),
              );
            }).toList(),
            style: textStyle,
            value: 'Low',
            onChanged: null,
          )
        ],)
    );
  }

}
