import 'package:flutter/material.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  String text="Test 1";
  void _incrementCounter() {
setState(() {


});


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(


        child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:38.0,left:30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:120,left:28.0),
                      child: Image.asset(
                        'assets/icon.png',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:95,right:1.0),
                      child: Text("Stickling",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 45,
                            fontWeight: FontWeight.bold
                        ),),
                    ),

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:5,right:1.0),
                child: Text("Just Like Tinder, But for Plants!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.normal
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15,right:1.0),
                child: Text("Match your plants new you in order",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15,right:1.0),
                child: Text("to make a trade",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top:88.0),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.green,
                      shape: BoxShape.rectangle,
                      borderRadius:BorderRadius.all(
                          Radius.circular(25)
                      )
                  ),
                  height: 100,
                  width: 250,

                  child: Center(
                    child: Text("How does it work?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.normal
                      ),),
                  ),
                ),
              )
              ]

        )
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
