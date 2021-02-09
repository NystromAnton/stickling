import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';
class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Container(
        height: 150,
        width: 250,
        color: Colors.pinkAccent,
        child: Center(
          child: Row(
            children: <Widget>[

              Text("TEst1"),
              Padding(
                padding: const EdgeInsets.only(left:50,top:18.0),
                child: Text("Test2",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.green
                  ),),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}