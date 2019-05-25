import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TodoFriend extends StatefulWidget {
  String id;
  TodoFriend(this.id);
  @override
  State<StatefulWidget> createState() {
    return TodoFriendState(id);
  }
}

class TodoFriendState extends State {
    String id;
  TodoFriendState(this.id);

  var data;
  Future<String> makeRequest() async {
      String url = 'https://jsonplaceholder.typicode.com/todos?userId='+id;
    var response = await http.get(Uri.encodeFull(url));
    setState(() {
      data = json.decode(response.body).cast<Map<String, dynamic>>();
    });
  }

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo")),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, i) {
                return new Container(
                      
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(data[i]["id"].toString()),
                            ),
                            
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(data[i]["title"]),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: data[i]["completed"] == true ? Text("Completed" ,style: TextStyle(color: Colors.green),) : Text(""),
                            ),
                          ],
                        ),
                    );
              },
            ),
    );
  }
}