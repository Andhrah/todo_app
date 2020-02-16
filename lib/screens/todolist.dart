import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/util/dbhelper.dart';


/// TodoList class
/// 
/// This class extends a stateful widget 
class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

/// TodoListState class
/// 
/// This class extends state.
class TodoListState extends State {
  /// Use DbHelper to retrieve the data
  DbHelper helper = DbHelper();
  List<Todo> todos;
  // count contain the number of record in the todo table
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todos == null) {
      todos = List<Todo>();
      getData();
    }
    return Scaffold(
      body: todoListItem(),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Add new Todo',
        ),
    );
  }

  ListView todoListItem() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(this.todos[position].id.toString()),
            ),
            title: Text(this.todos[position].title),
            subtitle: Text(this.todos[position].date),
            onTap: () {
              debugPrint('Tapped on ' + this.todos[position].id.toString());
            },
          )
        );
      }
    );
  }

  void getData() {
    final dbFuture = helper.initializeDb();
    dbFuture.then((result) {
      final todosFuture = helper.getTodos();
      todosFuture.then((result){
        List<Todo> todoList = List<Todo>();
        count = result.length;
        for (int i = 0; i < count; i++) {
          todoList.add(Todo.fromObject(result[i]));
          debugPrint(todoList[i].title);
        }
        setState(() {
          todos = todoList;
          count = count;
        });
        debugPrint('Items ' + count.toString());
      });
    });
  }
}
