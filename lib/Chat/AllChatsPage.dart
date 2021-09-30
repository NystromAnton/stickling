import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'ChatPage.dart';

class AllChatsPage extends StatefulWidget {
  String currentUserID;

  AllChatsPage(String currentUserID) {
    this.currentUserID = currentUserID;
  }
  @override
  _AllChatsPageState createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
  Future<List<dynamic>> getMyChatRooms() async {
    String url = "https://sticklingar.herokuapp.com/chatRoom/user/" +
        widget.currentUserID;
    final response = await http.get(url);

    List<dynamic> chatRooms = (json.decode(response.body) as List);
    print(chatRooms);
    return chatRooms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: FutureBuilder(
                  future: getMyChatRooms(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.teal,
                      ));
                    } else {
                      List chatRooms = snapshot.data;
                      return Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount: chatRooms.length,
                            itemBuilder: (context, i) {
                              String otherUser;
                              String meUser;
                              String message = "";
                              if (chatRooms[i]["user1"]["_id"] ==
                                  widget.currentUserID) {
                                otherUser = "user1";
                                otherUserPlant = "plant1";
                                meUser = "user2";
                              } else {
                                otherUser = "user2";
                                otherUserPlant = "plant2";
                                meUser = "user1";
                              }
                              if (chatRooms[i]["recent_chat"] != null) {
                                message =
                                    chatRooms[i]["recent_chat"]["message"];
                              }
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                        chatRooms[i]["_id"],
                                        widget.currentUserID,
                                        chatRooms[i][otherUser]["name"],
                                        chatRooms[i][meUser]["name"],
                                        chatRooms[i][otherUserPlant]["pic"][0],
                                      ),
                                    ),
                                  );
                                },
                                child: new Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 100,
                                    width: 150,
                                    color: Colors.white,
                                    child: Row(
                                      children: [
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
                                                      chatRooms[i][otherUser]
                                                          ["name"],
                                                      style: TextStyle(
                                                          fontFamily: 'Lato',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Text(
                                                  message,
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
                                ),
                              );
                            }),
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
