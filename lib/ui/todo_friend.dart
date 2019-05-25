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
      appBar: AppBar(title: Text("Album")),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, i) {
                return new Card(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                  children: <Widget>[
                          ListTile(
                            title: Text(data[i]["id"].toString()),
                          ),
                          ListTile(
                            title: Text(data[i]["title"]),
                          ),
                          ListTile(
                            title: Text(data[i]["completed"].toString()),
                          )
                        //  Text(data[i]["id"].toString()+':'+data[i]["name"]),
                        //  Text(data[i]["email"]),
                        //  Text(data[i]["phone"]),
                        //  Text(data[i]["website"]),
                       
                
                  ],
                )
                    ),
                );
              },
            ),
    );
  }
}