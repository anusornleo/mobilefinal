import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableTodo = 'todo';
final String columnId = 'id';
final String columnUsername = 'username';
final String columnAge = 'age';
final String columnName = 'name';
final String columnPassword = 'password';

class Todo {
  int _id;
  String _username;
  String _password;
  String _age;
  String _name;


  Todo.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._username = map['username'];
    this._password = map['password'];
    this._age = map['age'];
    this._name = map['name'];
 
  }

  Map<String, dynamic> toMap() {
    // map data between _username and _done as Map
    Map<String, dynamic> map = {
      columnUsername: _username,
      columnPassword: _password,
      columnAge: _age,
      columnName: _name,

    };
    if (_id != null) {
      map[columnId] = _id;
    }
    return map;
  }

  Todo.getValue(username, password, age, name) {
    // Get value from addItemScreen
    this._username = username;
    this._password = password;
    this._age = age;
    this._name = name;

  }

  Todo.map(dynamic obj) {
    // Map Object to varlable
    this._id = obj['id'];
    this._username = obj['username'];
    this._password = obj['password'];
    this._age = obj['age'];
    this._name = obj['name'];
  }

  // getter and setter
  int get id => _id;
  String get username => _username;
  String get password => _password;
  String get age => _age;
  String get name => _name;

  Todo(); // constructor
}

class TodoDatabase {
  static final TodoDatabase _instance = new TodoDatabase.internal();
  factory TodoDatabase() => _instance;
  static Database _db;
  TodoDatabase.internal(); // start Database auto

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableTodo($columnId INTEGER PRIMARY KEY, $columnUsername TEXT,$columnPassword TEXT,$columnAge TEXT,$columnName TEXT)');
  }

  Future<int> saveNewTask(Todo todo) async {
    // save naw task from addItemscreen
    var dbClient = await db;
    var result = await dbClient.insert(tableTodo, todo.toMap());
    return result;
  }

  Future<List> getAllTask() async {
    // get data of row done = 0 (not done)
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableTodo,
        columns: [
          columnId,
          columnUsername,
          columnPassword,
          columnAge,
          columnName,
        ],
        where: '$columnId > ?',
        whereArgs: [0]);
    return result;
  }

  // Future<List> getAllComplete() async {
  //   // get data of row done = 1 (done)
  //   var dbClient = await db;
  //   List<Map> result = await dbClient.query(tableTodo,
  //       columns: [columnId, columnUsername, columnDone],
  //       where: '$columnDone = ?',
  //       whereArgs: [1]);
  //   return result;
  // }

  // Future<int> eteAllDone() async {
  //   // ete aata of row done = 1 (done)
  //   var dbClient = await db;
  //   return await dbClient
  //       .ete(tableTodo, where: '$columnDone = ?', whereArgs: [1]);
  // }

  Future<int> updateNote(Todo todo) async {
    // update data of column done between 0 and 1 by id
    var dbClient = await db;
    print("update################################################");
    return await dbClient.update(tableTodo, todo.toMap(),
        where: "$columnId = ?", whereArgs: [todo.id]);
  }

  Future close() async {
    // close database (not use)
    var dbClient = await db;
    return dbClient.close();
  }
}
