import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/todo.dart';

/// DbHelper class contain constants that will help us
/// for our queries. 
/// 
/// It also contains methods to retrieve
/// the database and make reads and writes over it.
class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();

  String tableName = 'todo';
  String columnId =  'id';
  String columnTitle = 'title';
  String columnDescription = 'description';
  String columnPriority = 'priority';
  String columnDate = 'date';

  // named constructor
  DbHelper._internal();
  
  // unnamed constructor
  /// The factory constructor allows you to override
  /// the default behavior when you instantiate an object.
  /// 
  /// Instead of always creating a new instance, the factory
  /// constructor is only required to return one instance of the class.
  factory DbHelper() {
    return _dbHelper;
  }

  /// This is a variable that contain the database throughout the class.
  /// It's a static database called _db

  static Database _db;

  /// A Future is an object that will get a value sometime in the future
  /// 
  /// A method that returns a Future will immediately receive
  /// a Future object when called. And only when the code inside the 
  /// Future completes its execution, the .then method is called with 
  /// the result.

  /// This is a getter method that checks if the db is null
  /// and if its it will call `initializeDb` method.
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  /// This method create or open the database.
  ///
  // /This method will return a future of type Database
  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo.db';
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  /// This method will launch an SQL query to create database.
  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, ' + '$columnDescription TEXT, $columnPriority INTEGER, $columnDate TEXT)'
    );
  }

  /// SQL query method for inserting into the database.
  /// 
  /// This method write values into the database.
  Future<int> insertTodo(Todo todo) async {
    // Get the db.
    Database db = await this.db;
    var result = await db.insert(tableName, todo.toMap());
    return result;
  }

  /// SQL query method for selecting values from the database.
  /// 
  /// This method reads values from the database. 
  Future<List> getTodos() async {
      // Get the db.
    Database db = await this.db;
    var result = await db.rawQuery('SELECT * FROM $tableName order by $columnPriority ASC');
    return result;
  }

  /// SQL query method for selecting values from the database.
  /// 
  /// This method reads value from the database. It gets the
  /// number of record in our table.
  Future<int> getCount() async {
    // Get the db.
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
      await db.rawQuery('select count (*) from $tableName')
    );
    return result;
  }

  /// SQL query method for updating value in the database.
  /// 
  /// This method writes value into the database table. It updates
  /// a specific values in the db table.
  Future<int> updateTodo(Todo todo) async {
    // Get the db.
    var db = await this.db;
    var result = await db.update(tableName, todo.toMap(),
      where: '$columnId = ?', whereArgs: [todo.id]
    );
    return result;
  }

  /// SQL query method for deleting value from the database.
  /// 
  /// This method deletes value from the database table. It delete
  /// a specific values in the db table.
  Future<int> deleteTodo(int id) async {
    int result;
    // Get the db.
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tableName WHERE $columnId = $id');
    return result;
  }
}
