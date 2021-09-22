import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class SwipeTab extends StatefulWidget {
  String CurrentUserID;

  SwipeTab(String CurrentUserID) {
    this.CurrentUserID = CurrentUserID;
  }

  @override
  _SwipeTabState createState() => _SwipeTabState();
}

class _SwipeTabState extends State<SwipeTab> {
  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    requestMethod("").then((value) => print("API RESULT " + value.toString()));
  }

  CardController cardController = new CardController();

  Future<List<dynamic>> getMyPlants(String url) async {
    String url =
        "https://sticklingar.herokuapp.com/plants/" + widget.CurrentUserID;
    final response = await http.get(url);

    final responseJson = json.decode(response.body.toString());

    List<dynamic> plants = (json.decode(response.body) as List);

    return plants;
  }

  Future<List<dynamic>> requestMethod(String url) async {
    Addpreprefernces("", "").then((value) => print("Pref User ID " + value));

    String url = "https://sticklingar.herokuapp.com/nearby/" +
        widget.CurrentUserID +
        "/?q=17.61721,59.85877";

    final response = await http.get(url);

    final responseJson = json.decode(response.body.toString());

    List<dynamic> users = (json.decode(response.body) as List);

    return users;
  }

  Future<String> SwipeRight(String userID, String PlantID) async {
    var body =
        json.encode({"userId": widget.CurrentUserID, "plantId": PlantID});

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post("https://sticklingar.herokuapp.com/match",
        body: body, headers: headers);
    final responseJson = response.body.toString();

    return responseJson;
  }

  Future<String> Addpreprefernces(String userID, String PlantID) async {
    var body = json.encode({
      "id": widget.CurrentUserID,
      "types": ["monstera", "tulpan"],
      "distance": 100
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(
        "https://sticklingar.herokuapp.com/preference/add-preference",
        body: body,
        headers: headers);
    final responseJson = response.body.toString();

    return responseJson;
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;

    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: requestMethod(""),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.teal,
              ));
            } else {
              List images = snapshot.data;

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
                        maxWidth: MediaQuery.of(context).size.width * 1.0,
                        maxHeight: MediaQuery.of(context).size.height * 1.0,
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                        minHeight: MediaQuery.of(context).size.height * 0.8,
                        cardBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 28.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 30),
                                        child: Text(
                                          images[index]['title'].toString(),
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
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: welcomeImages[index],
                                        placeholder: (context, url) => SizedBox(
                                          width: 5,
                                          height: 5,
                                          child: new CircularProgressIndicator(
                                            backgroundColor: Colors.teal,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        cardController: cardController,
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
                          if (orientation == CardSwipeOrientation.LEFT) {
                          } else if (orientation ==
                              CardSwipeOrientation.RIGHT) {
                            SwipeRight("", images[index]['_id']).then(
                              (value) {
                                if (value.contains("Match object created")) {
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
                                        onPressed: () => Navigator.pop(context),
                                        width: 120,
                                      )
                                    ],
                                  ).show();
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.grey[400],
                                )),
                            child: IconButton(
                                icon: Icon(Icons.close, color: Colors.red[700]),
                                onPressed: () {
                                  cardController.triggerLeft();
                                },
                                iconSize: 60),
                          ),
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.grey[400],
                                )),
                            child: IconButton(
                                icon: Icon(Icons.favorite_rounded,
                                    color: Colors.pink[300]),
                                onPressed: () => {
                                      {
                                        SwipeRight("", images[0]['_id'])
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
      ),
    );
  }
}