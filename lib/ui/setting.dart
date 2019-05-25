import 'package:mobilefinal2/model/modelUser.dart';
import 'package:mobilefinal2/ui/wait.dart';
import 'package:flutter/material.dart';
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
  TextEditingController _dob = new TextEditingController();

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
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: "old : " + userdata.password.toString(),
                    hintText: "Plaease input you email",
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                ),
                TextFormField(
                  controller: _age,
                  decoration: InputDecoration(
                    labelText: "old : " + userdata.password.toString(),
                    hintText: "Plaease input you email",
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                ),
                TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                    labelText: "old : " + userdata.password.toString(),
                    hintText: "Plaease input you email",
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                ),
    
                Builder(
                  builder: (context) => RaisedButton(
                      child: Text('OK'),
                      onPressed: () async {
                        print(_username.text);
                        print(_password.text);
                        print(isChecked);
                        print(_year);
                        print(_gen);
                        print(_dob.text);
                        db.updateNote(Todo.fromMap({
                          'id': userdata.id, // old id
                          'username': _username.text, // old title
                          'password': _password.text,
                          'age': _age.text,
                          'name': _name.text,
                        }));
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
