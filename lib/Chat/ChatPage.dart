import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:async';

class ChatPage extends StatefulWidget {
  String chatRoomID;
  String currentUserID;
  String otherName;
  String myName;
  String plantPicUrl;


  ChatPage(String chatRoomID, String currentUserID, String otherName,
      String myName, String plantPicUrl) {
    this.chatRoomID = chatRoomID;
    this.currentUserID = currentUserID;
    this.otherName = otherName;
    this.myName = myName;
    this.plantPicUrl = plantPicUrl;
  }
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = new TextEditingController();
  ScrollController scrollController = new ScrollController();
  Future<List<dynamic>> _future;

  Future<List<dynamic>> getMyChatMessages() async {
    String url = "https://sticklingar.herokuapp.com/chat/" + widget.chatRoomID;
    final response = await http.get(url);

    List<dynamic> chatMessages = (json.decode(response.body) as List);
    return chatMessages;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _future = getMyChatMessages();
    });
    setUpTimedFetch();
  }

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 5000), (timer) {
      setState(() {
        _future = getMyChatMessages();
      });
    });
  }

  void sendChat() async {
    var body = json.encode({
      "chatRoom": widget.chatRoomID,
      "fromID": widget.currentUserID,
      "message": messageController.text,
    });
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post("https://sticklingar.herokuapp.com/chat/",
        body: body, headers: headers);
    final responseJson = response.body.toString();

    messageController.clear();
    setState(() {
        _future = getMyChatMessages();
      });
  }

  void scrollToEnd() {
    scrollController.animateTo(
           0.0,
           duration: const Duration(milliseconds: 20),
           curve: Curves.fastOutSlowIn);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                flexibleSpace: SafeArea(
                  child: Container(
                    padding: EdgeInsets.only(right: 16),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.plantPicUrl),
                          maxRadius: 20,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.otherName,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Online",
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.settings,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.teal,
                      ));
                    } else {
                      List chatMessages = snapshot.data;

                      return Container(
                        height: 610,
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: chatMessages.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          reverse: true,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                alignment: (chatMessages[i]["fromID"] ==
                                        widget.currentUserID
                                    ? Alignment.topRight
                                    : Alignment.topLeft),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (chatMessages[i]["fromID"] ==
                                            widget.currentUserID
                                        ? Colors.blue[200]
                                        : Colors.grey.shade200),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    chatMessages[i]["message"],
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () => sendChat(),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: Colors.blue,
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
