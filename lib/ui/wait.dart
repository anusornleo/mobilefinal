import 'package:mobilefinal2/model/modelUser.dart';
import 'package:mobilefinal2/ui/login.dart';
import 'package:mobilefinal2/ui/mainHome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wait extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WaitState();
  }
}

class WaitState extends State {
  List<Todo> items = new List();
  final prefs = SharedPreferences.getInstance();

  TodoDatabase db = TodoDatabase();
  @override
  Future initState() {
    super.initState();
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
    print(stateLogin);
    if (stateLogin != 0) {
      print("Alrady login");
      var dataUser =
          items.singleWhere((i) => i.id == stateLogin, orElse: () => null);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => MainHome(dataUser, items)));
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
