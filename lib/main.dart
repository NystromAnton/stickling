import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stycling/ChatTab.dart';
import 'package:stycling/Profile/EditProfile.dart';
import 'package:stycling/ProfileTab.dart';
import 'package:stycling/settings.dart';
import 'package:stycling/swipeTab.dart';
import 'Profile/ProfilePage.dart';
import 'Walkthrough/Walkthrough.dart';

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
  @override
  void initState() {}

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
          ),
          body: SingleChildScrollView(
            child: Container(
              height: 850,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SwipeTab(widget.CurrentUserID),
                  ChatTab(widget.CurrentUserID),
                  ProfileTab(widget.CurrentUserID),
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
  @override
  Widget build(BuildContext context) {}
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {}
}
