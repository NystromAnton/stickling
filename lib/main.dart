import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stycling/Profile/EditProfile.dart';
import 'package:stycling/settings.dart';
import 'Profile/ProfilePage.dart';
import 'Walkthrough/Walkthrough.dart';
import 'settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
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
      home: Walkthrough(),
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

@override
void initState() {}

class TabBarDemo extends StatefulWidget {
  String CurrentUserID;

  TabBarDemo(String CurrentUserID) {
    this.CurrentUserID = CurrentUserID;
  }

  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
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

  CardController cardController = new CardController();

  @override
  void initState() {
    print("Init state is working ");
    requestMethod("").then((value) => print("API RESULT " + value.toString()));
  }

  Future<List<dynamic>> getMyPlants(String url) async {
    String url =
        "https://sticklingar.herokuapp.com/plants/" + widget.CurrentUserID;
    print("URL " + url.toString());
    final response = await http.get(url);

    print("response " + response.toString());
    final responseJson = json.decode(response.body.toString());

    print("result " + responseJson.toString());
    // Map map =json.decode(response.body);
    // print("map " + map.toString());
    List<dynamic> plants = (json.decode(response.body) as List);

    return plants;
  }

  Future<List<dynamic>> requestMethod(String url) async {
    Addpreprefernces("", "").then((value) => print("Pref User ID " + value));
    print("Current User ID " + widget.CurrentUserID);

    String url = "https://sticklingar.herokuapp.com/nearby/" +
        widget.CurrentUserID +
        "/?q=17.61721,59.85877";
    print("URL " + url.toString());
    final response = await http.get(url);

    print("response " + response.toString());
    final responseJson = json.decode(response.body.toString());

    print("result " + responseJson.toString());
    // Map map =json.decode(response.body);
    // print("map " + map.toString());
    List<dynamic> users = (json.decode(response.body) as List);

    return users;
  }

  Future<String> SwipeRight(String userID, String PlantID) async {
    var body =
        json.encode({"userId": widget.CurrentUserID, "plantId": PlantID});
    print("USER ID " + widget.CurrentUserID);
    print("Plant  ID " + PlantID);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post("https://sticklingar.herokuapp.com/match",
        body: body, headers: headers);
    final responseJson = response.body.toString();
    print("result " + responseJson);
    return responseJson;
  }

  Future<String> Addpreprefernces(String userID, String PlantID) async {
    var body = json.encode({
      "id": widget.CurrentUserID,
      "types": ["monstera", "tulpan"],
      "distance": 100
    });

    print("USER ID " + widget.CurrentUserID);
    print("Plant  ID " + PlantID);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(
        "https://sticklingar.herokuapp.com/preference/add-preference",
        body: body,
        headers: headers);
    final responseJson = response.body.toString();
    print("result " + responseJson);
    return responseJson;
  }

  @override
  Widget build(BuildContext context) {
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
              indicatorColor: Colors.green,
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
                  FutureBuilder(
                    future: requestMethod(""),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Colors.teal,
                        ));
                      } else {
                        List images = snapshot.data;
                        print("-----");
                        print(images);

                        List<String> welcomeImages = List<String>();
                        for (int i = 0; i < images.length; i++) {
                          welcomeImages.add(images[i]["pic"]);
                        }
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 550,
                                child: new TinderSwapCard(
                                  swipeUp: true,
                                  swipeDown: true,
                                  orientation: AmassOrientation.RIGHT,
                                  totalNum: welcomeImages.length,
                                  stackNum: 3,
                                  swipeEdge: 4.0,
                                  cardController: cardController,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 1.0,
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 1.0,
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.8,
                                  minHeight:
                                      MediaQuery.of(context).size.height * 0.8,
                                  cardBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 28.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 30),
                                                  child: Text(
                                                    images[index]['title']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 40,
                                                      fontFamily: 'Lato',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 350,
                                              width: 350,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      welcomeImages[index],
                                                  placeholder: (context, url) =>
                                                      SizedBox(
                                                    width: 5,
                                                    height: 5,
                                                    child:
                                                        new CircularProgressIndicator(
                                                      backgroundColor:
                                                          Colors.teal,
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          new Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //cardController: controller = CardController(),
                                  swipeUpdateCallback:
                                      (DragUpdateDetails details,
                                          Alignment align) {
                                    /// Get swiping card's alignment
                                    if (align.x < 0) {
                                      //Card is LEFT swiping

                                    } else if (align.x > 0) {
                                      //Card is RIGHT swiping

                                    }
                                  },
                                  swipeCompleteCallback:
                                      (CardSwipeOrientation orientation,
                                          int index) {
                                    if (orientation ==
                                        CardSwipeOrientation.LEFT) {
                                    } else if (orientation ==
                                        CardSwipeOrientation.RIGHT) {
                                      SwipeRight("", images[index]['_id'])
                                          .then((value) {
                                        print("Result " + value);
                                        if (value
                                            .contains("Match object created")) {
                                        } else {
                                          Alert(
                                            context: context,
                                            type: AlertType.success,
                                            title: "New Match",
                                            desc: "Great! You got a new Match",
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Chat",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                width: 120,
                                              )
                                            ],
                                          ).show();
                                        }
                                      });
                                    }

                                    /// Get orientation & index of swiped card!
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                            color: Colors.grey[400],
                                          )),
                                      child: IconButton(
                                          icon: Icon(Icons.close,
                                              color: Colors.red[700]),
                                          onPressed: () {
                                            cardController.triggerLeft();
                                            //TriggerDirection.left,
                                            //print("nope")
                                          },
                                          iconSize: 60),
                                    ),
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                            color: Colors.grey[400],
                                          )),
                                      child: IconButton(
                                          icon: Icon(Icons.favorite_rounded,
                                              color: Colors.pink[300]),
                                          onPressed: () => {
                                                {
                                                  //TriggerDirection.right,
                                                  SwipeRight(
                                                          "", images[0]['_id'])
                                                      .then((value) {
                                                    print("Result " + value);
                                                    if (value.contains(
                                                        "Match object created")) {
                                                    } else {
                                                      Alert(
                                                        context: context,
                                                        type: AlertType.success,
                                                        title: "New Match",
                                                        desc:
                                                            "Great! You got a new Match",
                                                        buttons: [
                                                          DialogButton(
                                                            child: Text(
                                                              "Chat",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            ),
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            width: 120,
                                                          )
                                                        ],
                                                      ).show();
                                                    }
                                                  }),
                                                  cardController.triggerRight(),
                                                },
                                              },
                                          iconSize: 55),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  Container(
                    color: Colors.white,
                    child: Text("No Chat Functionaility right noe"),
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
                                color: Colors.grey,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettingsPage()),
                                  );
                                },
                                iconSize: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
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
                                        builder: (context) => PlantProfile(
                                            null, widget.CurrentUserID)),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: FutureBuilder(
                              future: getMyPlants(""),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: Colors.teal,
                                  ));
                                } else {
                                  // List<String> list = snapshot.data;
                                  print("SNAPSHOT" + snapshot.data.toString());
                                  List plantImages = snapshot.data;

                                  return Container(
                                    height: 500,
                                    child: ListView.builder(
                                      itemCount: plantImages.length,
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
                                                      BorderRadius.circular(
                                                          20.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: plantImages[i]
                                                        ["pic"],
                                                    placeholder:
                                                        (context, url) =>
                                                            SizedBox(
                                                      width: 80,
                                                      height: 80,
                                                      child:
                                                          new CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.teal,
                                                      ),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        new Icon(Icons.error),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: 8.0,
                                                          right: 10,
                                                          left: 20,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              plantImages[i]
                                                                  ["title"],
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => EditProfile(
                                                                            plantImages[i]["pic"],
                                                                            plantImages[i]["title"],
                                                                            plantImages[i]["desc"])));
                                                              },
                                                              child: Container(
                                                                width: 90,
                                                                height: 35,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border: Border
                                                                            .all(
                                                                          color:
                                                                              Colors.grey[500],
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(20))),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .edit_outlined,
                                                                        color: Colors
                                                                            .grey,
                                                                        size:
                                                                            25),
                                                                    Text(
                                                                      "Edit",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Lato',
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20),
                                                        child: Text(
                                                          plantImages[i]
                                                              ["desc"],
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Lato',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.black,
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
                                  );
                                }
                              }),
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
