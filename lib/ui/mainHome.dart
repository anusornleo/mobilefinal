import 'package:mobilefinal2/model/modelUser.dart';
import 'package:mobilefinal2/ui/Home.dart';
import 'package:mobilefinal2/ui/album.dart';
import 'package:mobilefinal2/ui/json_data_ui.dart';
import 'package:mobilefinal2/ui/profile.dart';
import 'package:mobilefinal2/ui/setting.dart';
import 'package:flutter/material.dart';

class MainHome extends StatelessWidget {
  List<Todo> items = new List();
  Todo dataUser;
  MainHome(this.dataUser, this.items);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text(
        //     "Home",
        //   ),
        // ),
        body: TabBarView(
          children: <Widget>[
            Home(dataUser, items),
            Friend(),
            Profile(dataUser),
            Album(),
            Setting(dataUser)
          ],
        ),
        bottomNavigationBar: new Material(
          color: Colors.blue,
          child: new TabBar(
            tabs: <Tab>[
              new Tab(
                icon: new Icon(Icons.view_quilt),
              ),
              new Tab(
                icon: new Icon(Icons.notifications),
              ),
              new Tab(
                icon: new Icon(Icons.explore),
              ),
              new Tab(
                icon: new Icon(Icons.person),
              ),
              new Tab(
                icon: new Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
