import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class ChatPage extends StatefulWidget {
  String chatRoomID;
  String currentUserID;
  String otherName;
  String myName;

  ChatPage(String chatRoomID, String currentUserID, String otherName,
      String myName) {
    this.chatRoomID = chatRoomID;
    this.currentUserID = currentUserID;
    this.otherName = otherName;
    this.myName = myName;
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
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i){
                            return Container(
                              padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                              child: Align(
                                alignment: (chatMessages[i]["fromID"] == widget.currentUserID?Alignment.topLeft:Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (chatMessages[i]["fromID"] == widget.currentUserID?Colors.grey.shade200:Colors.blue[200]),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(chatMessages[i]["message"], style: TextStyle(fontSize: 15),),
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
