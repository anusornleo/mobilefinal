import 'package:mobilefinal2/model/modelUser.dart';
import 'package:mobilefinal2/ui/wait.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class Setting extends StatefulWidget {
  Todo userdata;
  Setting(this.userdata);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingState(userdata);
  }
}

class SettingState extends State {

    Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localPathFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<File> writeContent(String data) async {
    final file = await _localPathFile;
    file.writeAsString('${data}');
  }

  
  TodoDatabase db = TodoDatabase();
  final Todo userdata;
  SettingState(this.userdata);

  String _gen = "male";
  List<String> years = ['1', '2', '3', '4'];
  String _year = '1';

  bool isChecked = true;

  final _formKey = GlobalKey<ScaffoldState>();

  void _handleRadioValueChange1(String value) {
    setState(() {
      _gen = value;
      print(_gen);
    });
  }

  TextEditingController _username = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _age = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _quote = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // @override
    // void dispose() {
    //   _username.dispose();
    //   super.dispose();
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: _username,
                  decoration: InputDecoration(
                    labelText: "old : " + userdata.username.toString(),
                    hintText: "Plaease input you email",
               
                  ),
                ),
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: "old : " + userdata.name,
                    hintText: "Plaease input you email",
                    
                  ),
                ),
                TextFormField(
                  controller: _age,
                  decoration: InputDecoration(
                    labelText: "old : " + userdata.age,
                    hintText: "Plaease input you email",
                    
                  ),
                ),
                TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                    labelText: "old : " + userdata.password.toString(),
                    hintText: "Plaease input you email",
                    
                  ),
                ),
                TextFormField(
                  maxLines: null,
                  controller: _quote,
                  decoration: InputDecoration(
                    labelText: "old : " + userdata.password.toString(),
                    hintText: "Plaease input you email",
                    
                  ),
                ),
    
                Builder(
                  builder: (context) => RaisedButton(
                      child: Text('OK'),
                      onPressed: () async {
                        db.updateNote(Todo.fromMap({
                          'id': userdata.id, // old id
                          'username': _username.text, // old title
                          'password': _password.text,
                          'age': _age.text,
                          'name': _name.text,
                        }));
                        writeContent(_quote.text);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Wait()));
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Define a Custom Form Widget
// class Setting extends StatefulWidget {
//   @override
//   _MyCustomFormState createState() => _MyCustomFormState();
// }

// class _MyCustomFormState extends State<Setting> {
//   final myController = TextEditingController(text: 'sfd');

//   @override
//   void dispose() {
//     myController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Retrieve Text Input'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             // TextField(
//             //   onChanged: (text) {
//             //     print("First text field: $text");
//             //   },
//             // ),
//             TextFormField(
//               controller: myController,
//             ),
//             RaisedButton(
//               child: Text("data"),
//               onPressed: () {
//                 print(myController.text);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
