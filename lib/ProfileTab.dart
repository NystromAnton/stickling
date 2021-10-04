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
import 'package:collection/collection.dart';

import 'Profile/ProfilePage.dart';
import 'settings.dart';

class ProfileTab extends StatefulWidget {
  String currentUserID;

  ProfileTab(String currentUserID) {
    this.currentUserID = currentUserID;
  }

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void dispose() {
    super.dispose();
  }

  Future<List<dynamic>> getMyPlants(String url) async {
    String url =
        "https://sticklingar.herokuapp.com/plants/" + widget.currentUserID;
    final response = await http.get(url);

    final responseJson = json.decode(response.body.toString());

    List<dynamic> plants = (json.decode(response.body) as List);

    return plants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    //Padding(
                    //padding: const EdgeInsets.only(left: 50.0),
                    //child:
                    Text(
                      'My Sticklings',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold),
                    ),
                    //),
                    IconButton(
                      icon: Icon(Icons.add_circle_rounded),
                      color: Color(0xFF65C27A),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PlantProfile(null, widget.currentUserID)),
                        );
                      },
                      iconSize: 40,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: FutureBuilder(
                  future: getMyPlants(""),
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
                      List plantImages = snapshot.data;
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                          itemCount: plantImages.length,
                          reverse: false,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                child: Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.11,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.11,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: CachedNetworkImage(
                                          imageUrl: plantImages[i]["pic"][0],
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              SizedBox(
                                            //width: MediaQuery.of(context).size.width * 0.2,
                                            //height: MediaQuery.of(context).size.height * 0.2,
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
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          /*Padding(
                                            padding: const EdgeInsets.only(
                                              right: 0,
                                              left: 20,
                                            ),
                                            child: */
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, top: 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  child: Text(
                                                    plantImages[i]["title"],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.edit_outlined),
                                                onPressed: () {
                                                  print(plantImages[i]["pic"]);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditProfile(
                                                                  plantImages[i]
                                                                      ["pic"].toString(),
                                                                  plantImages[i]
                                                                      ["title"],
                                                                  plantImages[i]
                                                                      [
                                                                      "desc"])));
                                                },
                                                iconSize: 30,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                          //),
                                          Padding(
                                            padding: EdgeInsets.only(left: 12),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.60,
                                              child: Text(
                                                plantImages[i]["desc"],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontFamily: 'Lato',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
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
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
