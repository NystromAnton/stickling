import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class ChatPage extends StatefulWidget {
  String chatRoomID;

  ChatPage(String chatRoomID, String currentUserID, String otherName,
      String myName) {
    this.chatRoomID = chatRoomID;
  }
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Future<List<dynamic>> getMyChatMessages() async {
    String url = "http://localhost:3000/chat/" + widget.chatRoomID;
    final response = await http.get(url);

    List<dynamic> chatMessages = (json.decode(response.body) as List);
    print(chatMessages);
    return chatMessages;
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
                  future: getMyChatMessages(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.teal,
                      ));
                    } else {
                      List chatMessages = snapshot.data;

                      return Container(
                        height: 500,
                        child: ListView.builder(
                          itemCount: chatMessages.length,
                          itemBuilder: (context, i) {
                            return Padding(
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
                                                  chatMessages[i]["message"],
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
