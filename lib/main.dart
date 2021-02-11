import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

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
      home: TabBarDemo(),
      //home: MyStatefulWidget(),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class TabBarDemo extends StatelessWidget {
  final List<String> flowerImages = [
    "assets/flower1.png",
    "assets/flower2.png",
    "assets/flower3.png"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 60,
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Color(0xFF65C27A),
              unselectedLabelColor: Color(0xFFB2E5BE),
              tabs: [
                Tab(
                    icon: ImageIcon(
                  AssetImage("assets/sticklinglogo.png"),
                  size: 50,
                )),
                Tab(
                    icon: ImageIcon(
                  AssetImage("assets/chaticon.png"),
                  size: 50,
                )),
                Tab(
                  icon: ImageIcon(
                    AssetImage("assets/myprofileicon.png"),
                    size: 50,
                  ),
                ),
              ],
            ),
            //title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 40),
                          child: Text(
                            'Julia\'s Palettblad',
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: '.SF UI Display',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.only(top: 40),
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              'assets/palettblad.png',
                              width: 400.0,
                              height: 400.0,
                              fit: BoxFit.cover,
                            ),
                          ),),
                          /* child: Container(
                            padding: EdgeInsets.only(top: 40),
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0), //doesn't work, why??
                            ),
                            child: Image.asset(
                              "assets/palettblad.png",
                              fit: BoxFit.fitWidth,
                            ),
                          ), */
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(70),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.grey[400],
                                )),
                            child: IconButton(
                                //padding: EdgeInsets.all(20),
                                icon: Icon(Icons.close, color: Colors.red[700]),
                                onPressed: null,
                                iconSize: 60),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          //padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.grey[400],
                              )),
                          child: IconButton(
                              //padding: EdgeInsets.all(20),
                              icon: Icon(Icons.favorite_rounded,
                                  color: Colors.pink[300]),
                              onPressed: null,
                              iconSize: 55),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
              ),
              Container(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  //Tillhör Mette och Helenas navbar
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Swipemode',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //title: const Text('BottomNavigationBar Sample'),
      //),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      //Mette och Helenas Navbar fast den är i botten :/
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/sticklinglogo.png"),
              size: 50,
            ),
            //icon: Icon(Icons.local_florist_rounded),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/chaticon.png"),
              size: 55,
            ),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/myprofileicon.png"),
              size: 50,
            ),
            label: ' ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF65C27A),
        onTap: _onItemTapped,
      ),
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
