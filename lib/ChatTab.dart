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
import 'settings.dart';

class ChatTab extends StatefulWidget {
  String CurrentUserID;

  ChatTab(String CurrentUserID) {
    this.CurrentUserID = CurrentUserID;
  }

  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Text("No Chat Functionaility right now"),
        ),
      ),
    );
  }
}
