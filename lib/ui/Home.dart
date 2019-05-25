import 'dart:io';

import 'package:mobilefinal2/model/modelUser.dart';
import 'package:mobilefinal2/ui/json_data_ui.dart';
import 'package:mobilefinal2/ui/login.dart';
import 'package:mobilefinal2/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:mobilefinal2/ui/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  String data;
  List<Todo> items = new List();
  Todo alldata;
  Home(this.alldata, this.items,this.data);
  @override
  State<StatefulWidget> createState() {
    return HomeState(alldata, items,data);
  }
}

class HomeState extends State {
  String data;
  List<Todo> items = new List();
  Todo alldata;
  HomeState(this.alldata, this.items,this.data);

  @override
  Widget build(BuildContext context) {
    print(data);

    return Scaffold(
        appBar: AppBar(title: Text("HOME")),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Text("Hello "+alldata.name,style: TextStyle(fontSize: 30),),
              Text("this is my quote "+data),
              RaisedButton(
                child: Text("Profile"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Setting(alldata)));
                },
              ),
              RaisedButton(
                child: Text("My Friends"),
                onPressed: (
                  
                ) {Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Friend()));},
              ),
              RaisedButton(
                child: Text("Sign out"),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove('user');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginForm(items)));
                },
              ),
            ],
          ),
        ));
  }
}
