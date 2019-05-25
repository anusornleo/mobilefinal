// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class Friend extends StatefulWidget {
//   @override
//   FriendState createState() => new FriendState();
// }

// class FriendState extends State<Friend> {
//   String url = 'https://jsonplaceholder.typicode.com/users';
//   List data;
//   Future<String> makeRequest() async {
//     var response = await http
//         .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

//     setState(() {
//       var extractdata = json.decode(response.body);
//       // print("object##################");
//       // print(extractdata.runtimeType);
//       data = extractdata["results"];
//       print(data);
//     });
//   }

//   @override
//   void initState() {
//     this.makeRequest();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return new Scaffold(
//     //     appBar: new AppBar(
//     //       title: new Text('Contact List'),
//     //     ),
//     //     body: data == null
//     //         ? Center(
//     //             child: CircularProgressIndicator(),
//     //           )
//     //         : new ListView.builder(
//     //             itemCount: data.length,
//     //             itemBuilder: (BuildContext context, i) {
//     //               return new ListTile(
//     //                   title: new Text(data[i]["name"]["first"]),
//     //                   subtitle: new Text(data[i]["phone"]),
//     //                   leading: new CircleAvatar(
//     //                     backgroundImage:
//     //                         new NetworkImage(data[i]["picture"]["thumbnail"]),
//     //                   ));
//     //             }));

//     return Scaffold(
//       appBar: AppBar(title: Text("Album")),
//       body: data == null
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (BuildContext context, i) {
//                 return new Card(
//                     child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       height: 180,
//                       child: Stack(
//                         children: <Widget>[
//                           Positioned.fill(
//                               child: Text(data[i]["name"]))
//                         ],
//                       ),
//                     )
//                   ],
//                 ));
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilefinal2/ui/album.dart';
import 'package:mobilefinal2/ui/todo_friend.dart';

class Friend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FriendState();
  }
}

class FriendState extends State {
  String url = 'https://jsonplaceholder.typicode.com/users';
  var data;
  Future<String> makeRequest() async {
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
                return GestureDetector(
                  onTap: (){
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TodoFriend(data[i]["id"].toString())));
        },
        
                    child: new Container(
                      
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(data[i]["id"].toString()+':'+data[i]["name"],style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                            ),
                            
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(data[i]["email"]),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(data[i]["phone"]),
                            ),
                            
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(data[i]["website"]),
                            ),
                            
                          ],

                        ),
                    ),
            
                );
              },
            ),
    );
  }
}

