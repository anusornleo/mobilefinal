import 'dart:io';

import 'package:mobilefinal2/model/modelUser.dart';
import 'package:mobilefinal2/ui/Home.dart';
import 'package:mobilefinal2/ui/login.dart';
import 'package:mobilefinal2/ui/mainHome.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wait extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WaitState();
  }
}

class WaitState extends State {
    String data = '';
    Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<String> readcontent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      this.data = contents;
      return this.data;
    } catch (e) {
      // If there is an error reading, return a default String
      return 'Error';
    }
  }



  List<Todo> items = new List();
  final prefs = SharedPreferences.getInstance();

  TodoDatabase db = TodoDatabase();
  @override
  Future initState() {
    super.initState();
    readcontent();
    db.getAllTask().then((todos) {
      setState(() {
        todos.forEach((note) {
          items.add(Todo.fromMap(note));
        });
        getLogin();
      });
    });
  }

  Future<String> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final stateLogin = prefs.get('user') ?? 0;
    print(data);
    if (stateLogin != 0) {
      print("Alrady login");
      var dataUser =
          items.singleWhere((i) => i.id == stateLogin, orElse: () => null);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Home(dataUser, items,data)));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginForm(items)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
