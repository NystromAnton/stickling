//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';
import 'Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: MyCustomForm(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String text = "Test 1";
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 38.0, left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 120, left: 28.0),
                child: Image.asset(
                  'assets/icon.png',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 95, right: 1.0),
                child: Text(
                  "Stickling",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 1.0),
          child: Text(
            "Just Like Tinder, But for Plants!",
            style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 1.0),
          child: Text(
            "Match your plants new you in order",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 1.0),
          child: Text(
            "to make a trade",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 88.0),
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.green,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            height: 100,
            width: 250,
            child: Center(
              child: Text(
                "How does it work?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        )
      ])),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 55),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: null,
                  iconSize: 35,
                  color: Color(0xFF65C27A),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 55, left: 10, right: 30), // Make this truly centered
                  child: TextField(
                    textDirection: TextDirection.ltr,
                    controller: titleController,
                    obscureText: false,
                    style: TextStyle(fontSize: 30),
                    cursorColor: Colors.black,
                    showCursor: false,
                    enableInteractiveSelection: false,
                    decoration: InputDecoration(
                      fillColor: Color(0xFF65C27A),
                      border: InputBorder.none,
                      prefixIcon:
                          Icon(Icons.edit, color: Colors.grey, size: 25),
                      hintText: 'Title',
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 375,
                  width: 375,
                  child: Icon(
                    Icons.control_point_outlined,
                    size: 80,
                    color: Color(0xFF000000).withOpacity(0.1),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9).withOpacity(.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.top,
                    controller: descriptionController,
                    maxLines: 5,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: 'Describe your plant...',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFD9D9D9).withOpacity(.5),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF000000).withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 0,
                child: RaisedButton(
                  onPressed: null,
                  child: Text(
                    'Upload plant',
                    style: TextStyle(fontSize: 25),
                  ),
                  textColor: Colors.white,
                  disabledTextColor: Colors.white,
                  color: Color(0xFF65C27A),
                  focusColor: Color(0xFF65C27A),
                  disabledColor: Color(0xFF65C27A),
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
