import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:geolocator/geolocator.dart';
import 'package:animations/animations.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:stycling/Chat/AllChatsPage.dart';
import 'package:stycling/Registration/Login.dart';
import 'package:stycling/settings.dart';

class SwipeTab extends StatefulWidget {
  String CurrentUserID;

  SwipeTab(String CurrentUserID) {
    this.CurrentUserID = CurrentUserID;
  }

  @override
  _SwipeTabState createState() => _SwipeTabState();
}

class _SwipeTabState extends State<SwipeTab> {
  int cardIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  double long;
  double lat;
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

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }


   Future<List<dynamic>> requestMethod(String url) async {
    Addpreprefernces("", "").then((value) => print("Pref User ID " + value));

     await determinePosition().then((value) {
        this.long = value.longitude;
        this.lat = value.latitude;
      });

    String url = "https://sticklingar.herokuapp.com/nearby/" +
        widget.CurrentUserID + "/?q=" + this.long.toString() + "," + this.lat.toString();

    final response = await http.get(url);
    final responseJson = json.decode(response.body.toString());
    List<dynamic> users = (json.decode(response.body) as List);
    return users;
  }


  Future<String> swipeRight(String userID, String plantID) async {
    var body =
    json.encode({"userId": widget.CurrentUserID, "plantId": plantID});

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post("https://sticklingar.herokuapp.com/match/",
        body: body, headers: headers);
    final responseJson = response.body.toString();

    print(responseJson);

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
        "https://sticklingar.herokuapp.com/preference/add-preference/",
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
              return Container(
                child: Align(
                  alignment: Alignment.center,
                  child: CupertinoActivityIndicator(
                    radius: 20,
                  ),
                ),
              );
            } else {
              List images = snapshot.data;

              List<String> welcomeImages = List<String>();
              for (int i = 0; i < images.length; i++) {
                welcomeImages.add(images[i]["pic"][0]);
              }
              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.97,
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
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: OpenContainer(
                                transitionDuration: Duration(milliseconds: 300),
                                openBuilder: (context, _) => DetailsPage(welcomeImages, images, index),
                                closedElevation: 0,
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    ),
                                closedColor: Colors.transparent,
                                closedBuilder: (context, _) =>
                                Container(
                                  child: Center(
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          child: CachedNetworkImage(
                                              imageUrl: welcomeImages[index],
                                              imageBuilder: (context, imageProvider) => Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  image: DecorationImage(image: imageProvider,
                                                  fit: BoxFit.cover),
                                                  ),
                                                ),
                                              placeholder: (context, url) => SizedBox(
                                                width: 5,
                                                height: 5,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: CupertinoActivityIndicator(
                                                    radius: 20,
                                                  ),
                                                ),
                                              ),
                                              errorWidget: (context, url, error) =>
                                              new Icon(Icons.error),
                                            ),
                                         ),
                                         Container(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).size.height*0.02,
                                                left: MediaQuery.of(context).size.width*0.05),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      images[index]['title'].toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 30,
                                                        fontFamily: 'Lato',
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.location_on_outlined,
                                                          color: Colors.white),
                                                          Text(
                                                            images[index]["distance"].toStringAsFixed(0) + " km",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: "Lato",
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ],
                                                      ),),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width*0.72,
                                                        padding: EdgeInsets.only(top: 10),
                                                        child: Text(
                                                          images[index]["desc"].toString(),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily: "Lato",
                                                            color: Colors.white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
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
                          cardIndex += 1;
                          if (orientation == CardSwipeOrientation.LEFT) {
                          } else if (orientation ==
                              CardSwipeOrientation.RIGHT) {
                            swipeRight("", images[index]['plantID']).then(
                                  (value) {
                                if (value.contains("Match")) {
                                  Alert(
                                    context: context,
                                    type: AlertType.success,
                                    title: "New Match",
                                    desc: "Great! You got a new Match",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "Chats",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed:() => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllChatsPage(widget.CurrentUserID)),
                                        ),
                                        width: 120,
                                      )
                                    ],
                                  ).show();
                                }
                                else if (value.contains("Chat")) {
                                  Alert(
                                    context: context,
                                    type: AlertType.success,
                                    title: "You've matched again!",
                                    desc: "Go check your chats",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "Chats",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllChatsPage(widget.CurrentUserID)),
                                        ),
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
                                  cardController.triggerRight(),
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


class DetailsPage extends StatelessWidget {
  final welcomeImages;
  final images;
  final index;

  DetailsPage(this.welcomeImages, this.images, this.index);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child:
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 45, right: MediaQuery.of(context).size.width *
                  0.75),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: null,
                  iconSize: 35,
                  color: Color(0xFF65C27A),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width:
                  MediaQuery.of(context).size.width *
                      0.75,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      images[index]['title'].toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.4,
              width:
              MediaQuery.of(context).size.width * 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: welcomeImages[index],
                  placeholder: (context, url) => SizedBox(
                    width: 5,
                    height: 5,
                    child: Align(
                      alignment: Alignment.center,
                      child: CupertinoActivityIndicator(
                        radius: 20,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                  new Icon(Icons.error),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.72,
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      images[index]['desc'].toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}