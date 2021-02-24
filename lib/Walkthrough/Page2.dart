import 'dart:io';
import 'package:stycling/Registration/Login.dart';
import 'package:stycling/Walkthrough/Page1.dart';
import 'package:stycling/main.dart';
import 'package:stycling/Registration/Signup.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Page3.dart';

class Page2 extends StatefulWidget {
  Page2() {}

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Text(
                      'How Stickling works',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Image.asset(
                      'assets/flower2.png',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Create a profile for your plant',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40,
                    ),
                    child: Text(
                      'Upload a photo and write a',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      'short description of the plant',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      'you wish to trade.',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Lato',
                          color: Colors.grey[800],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        Icons.circle,
                        color: Color(0xFF65C27A),
                        size: 18,
                    ),
                    Icon(
                        Icons.circle,
                        color: Color(0xFFB2E5BE),
                        size: 18,
                    ),
                    Icon(
                        Icons.circle,
                        color: Color(0xFFB2E5BE),
                        size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Text(
                      'How Stickling works',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Image.asset(
                      'assets/flower1.png',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Swipe and match with other',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Text(
                      'plants near you',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40,
                    ),
                    child: Text(
                      'Find the plants that you find attractive',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      'and like them. If the same plant liked',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      'you back, you get a match.',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Lato',
                          color: Colors.grey[800],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        Icons.circle,
                        color: Color(0xFFB2E5BE),
                        size: 18,
                    ),
                    Icon(
                        Icons.circle,
                        color: Color(0xFF65C27A),
                        size: 18,
                    ),
                    Icon(
                        Icons.circle,
                        color: Color(0xFFB2E5BE),
                        size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Text(
                      'How Stickling works',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Image.asset(
                      'assets/flower3.png',
                      height: 250,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Chat with your matches and',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Text(
                      'trade your plants',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40,
                    ),
                    child: Text(
                      'Once you’ve matched with another',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      'plant you are able to chat with them.',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      'Happy trading!',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Padding(
              padding: EdgeInsets.only(top: 40),
              child: RaisedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                ),
                child: Text(
                  'Let\'s go!',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Lato',
                  ),
                ),
                textColor: Colors.white,
                color: Color(0xFF65C27A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        Icons.circle,
                        color: Color(0xFFB2E5BE),
                        size: 18,
                    ),
                    Icon(
                        Icons.circle,
                        color: Color(0xFFB2E5BE),
                        size: 18,
                    ),
                    Icon(
                        Icons.circle,
                        color: Color(0xFF65C27A),
                        size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}