import 'package:mobilefinal2/model/modelUser.dart';
import 'package:mobilefinal2/ui/Home.dart';
import 'package:mobilefinal2/ui/mainHome.dart';
import 'package:mobilefinal2/ui/signIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  List<Todo> items = new List();
  LoginForm(this.items);
  @override
  State<StatefulWidget> createState() {
    return LoginFormState(items);
  }
}

class LoginFormState extends State<LoginForm> {
  List<Todo> items = new List();
  LoginFormState(this.items);
  final TextEditingController _user = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final _formKey = GlobalKey<ScaffoldState>();
  final prefs = SharedPreferences.getInstance();
  TodoDatabase db = TodoDatabase();
  String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 50, left: 30, right: 30),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Image.asset(
              "img/iconfinder_Key_379460.png",
              height: 150,
            ),
            TextFormField(
              controller: _user,
              decoration: InputDecoration(
                labelText: "User Id",
                hintText: "Plaease input you email",
                prefixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Plaease input you Password",
                prefixIcon: Icon(Icons.lock),
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            Builder(
              builder: (context) => RaisedButton(
                  child: Text('LOGIN'),
                  onPressed: () async {
                    if (_user.text.isEmpty || _password.text.isEmpty) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Please fill out this form'),
                        duration: Duration(seconds: 3),
                      ));
                    } else {
                      for (var i in items) {
                        if (_user.text == i.username &&
                            _password.text == i.password) {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setInt("user", i.id);
                          // prefs.remove('user');
                          print(prefs.getInt('user') ?? 0);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home(i, items,data)));
                        }
                      }
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Invalid user or password'),
                        duration: Duration(seconds: 3),
                      ));
                    }
                  }),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ButtonTheme(
                padding: EdgeInsets.all(0),
                child: FlatButton(
                  child: Text(
                    "Register New Account",
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInForm(items)));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
