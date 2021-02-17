import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

import 'Profile/ProfilePage.dart';
import 'Registration/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  @override
  _ExampleHomePageState createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage>
    with TickerProviderStateMixin {
  List<String> welcomeImages = [
    "assets/stickling1.jpg",
    "assets/stickling2.jpg",
    "assets/stickling3.jpg",
    "assets/stickling4.png"
  ];

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return new Scaffold(
      body: new Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: new TinderSwapCard(
            swipeUp: true,
            swipeDown: true,
            orientation: AmassOrientation.BOTTOM,
            totalNum: welcomeImages.length,
            stackNum: 3,
            swipeEdge: 4.0,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (context, index) => Card(
              child: Image.asset('${welcomeImages[index]}'),
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping
              } else if (align.x > 0) {
                //Card is RIGHT swiping
              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              /// Get orientation & index of swiped card!
            },
          ),
        ),
      ),
    );
  }
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
      home: Login(),
      //home: TabBarDemo(),
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
    "assets/stickling1.jpg",
    "assets/stickling2.jpg",
    "assets/stickling3.jpg",
    "assets/stickling4.png",
    "assets/stickling1.jpg",
    "assets/stickling2.jpg",
    "assets/stickling3.jpg",
    "assets/stickling4.png",
    "assets/stickling1.jpg",
    "assets/stickling2.jpg",
    "assets/stickling3.jpg",
    "assets/stickling4.png",
    "assets/stickling1.jpg",
    "assets/stickling2.jpg",
    "assets/stickling3.jpg",
    "assets/stickling4.png"
  ];

  final List<String> Title = [
    "Flower 1",
    "Flower 2",
    "Flower 1",
    "Flower 2",
    "Flower 3",
    "Flower 1",
    "Flower 2",
    "Flower 1",
    "Flower 2",
    "Flower 3",
    "Flower 1",
    "Flower 2",
    "Flower 1",
    "Flower 2",
    "Flower 3",
    "Flower 4"
  ];
  final List<String> Description = [
    "Description 1",
    "Description 2",
    "Description 1",
    "Description 2",
    "Description 3",
    "Description 1",
    "Description 2",
    "Description 1",
    "Description 2",
    "Description 3",
    "Description 1",
    "Description 2",
    "Description 1",
    "Description 2",
    "Description 3",
    "Description 2"
  ];

  @override
  Widget build(BuildContext context) {
    List<String> welcomeImages = [
      "assets/stickling1.jpg",
    ];
    CardController controller;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 60,
            backgroundColor: Colors.white,
            bottom: TabBar(
              physics: NeverScrollableScrollPhysics(),
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
          body: SingleChildScrollView(
            child: Container(
              height: 850,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
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
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: new TinderSwapCard(
                            swipeUp: true,
                            swipeDown: true,
                            orientation: AmassOrientation.BOTTOM,
                            totalNum: welcomeImages.length,
                            stackNum: 3,
                            swipeEdge: 4.0,
                            maxWidth: MediaQuery.of(context).size.width * 0.9,
                            maxHeight: MediaQuery.of(context).size.width * 0.9,
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            minHeight: MediaQuery.of(context).size.width * 0.8,
                            cardBuilder: (context, index) => Card(
                              child: Image.asset('${welcomeImages[index]}'),
                            ),
                            cardController: controller = CardController(),
                            swipeUpdateCallback:
                                (DragUpdateDetails details, Alignment align) {
                              /// Get swiping card's alignment
                              if (align.x < 0) {
                                //Card is LEFT swiping
                              } else if (align.x > 0) {
                                //Card is RIGHT swiping
                              }
                            },
                            swipeCompleteCallback:
                                (CardSwipeOrientation orientation, int index) {
                              /// Get orientation & index of swiped card!
                            },
                          ),
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
                                    icon: Icon(Icons.close,
                                        color: Colors.red[700]),
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
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 15, left: 10),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.settings),
                                onPressed: null,
                                iconSize: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 45.0),
                                child: Text(
                                  'My Sticklings',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: RaisedButton(
                                  onPressed: null,
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    'Add new plant',
                                    style: TextStyle(
                                      fontSize: 25,
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                  disabledColor: Color(0xFF65C27A),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlantProfile(null)),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Container(
                            height: 500,
                            child: ListView.builder(
                              itemCount: flowerImages.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 100,
                                    width: 150,
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.asset(
                                              flowerImages[i],
                                              width: 100.0,
                                              height: 400.0,
                                              fit: BoxFit.cover,
                                            )),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 8.0,
                                                  right: 10,
                                                  left: 20,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      Title[i],
                                                      style: TextStyle(
                                                          fontFamily: 'Lato',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 25),
                                                    ),
                                                    Container(
                                                      width: 90,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[500],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              color:
                                                                  Colors.grey,
                                                              size: 25),
                                                          Text(
                                                            "Edit",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Lato',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Text(
                                                  Description[i],
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
