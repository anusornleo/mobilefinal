import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:mobilefinal2/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/modelUser.dart';

class SignInForm extends StatefulWidget {
  List<Todo> items = new List();
  SignInForm(this.items);
  @override
  State<StatefulWidget> createState() {
    return SignInFormState(items);
  }
}

class SignInFormState extends State<SignInForm> {
  List<Todo> items = new List();
  SignInFormState(this.items);
  TodoDatabase db = TodoDatabase();
  final TextEditingController _userID = new TextEditingController();
  
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _age = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final _formKey2 = GlobalKey<ScaffoldState>();

  List<Todo> listTodo;

  String _gen = "";
  List<String> years = ['1', '2', '3', '4'];
  String _year = '1';
  bool isChecked = false;

  void _handleRadioValueChange1(String value) {
    setState(() {
      _gen = value;
      print(_gen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("REGISTER"),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
          child: Form(
            key: _formKey2,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Colors.blue),
                  controller: _userID,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: "Plaease input you email",
                    hintStyle: TextStyle(color: Colors.blue[200]),
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.blue,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.blue),
                  controller: _name,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: "Plaease input you email",
                    hintStyle: TextStyle(color: Colors.blue[200]),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.blue),
                  controller: _age,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: "Age",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: "Plaease input you Password",
                    hintStyle: TextStyle(color: Colors.blue[200]),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                  ),
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.blue),
                  controller: _password,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: "Plaease input you Password",
                    hintStyle: TextStyle(color: Colors.blue[200]),
                    prefixIcon: Icon(Icons.lock, color: Colors.blue),
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                
                Builder(
                  builder: (context) => RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "REGISTER NEW ACCOUNT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_userID.text.isEmpty ||
                            _password.text.isEmpty ||
                            _name.text.isEmpty) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Please Input All Field'),
                            duration: Duration(seconds: 3),
                          ));
                        } else {
                          db
                              .saveNewTask(Todo.getValue(
                                  _userID.text,
                                  _password.text,
                                  isChecked.toString(),
                                  _age.text))
                              .then((_) {
                            items.clear();
                            db.getAllTask().then((todos) {
                              // restart read data when it changed
                              setState(() {
                                print(todos.length);
                                todos.forEach((note) {
                                  items.add(Todo.fromMap(note));
                                  print(items.length);
                                  // print(items[0].toMap());
                                });
                              });
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginForm(items)));
                          });
                        }
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
