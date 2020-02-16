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
}
