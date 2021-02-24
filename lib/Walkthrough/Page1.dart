import 'dart:io';
import 'package:stycling/Registration/Login.dart';
import 'package:stycling/Walkthrough/Page2.dart';
import 'package:stycling/main.dart';
import 'package:stycling/Registration/Signup.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Page3.dart';

//import 'Page2.dart';

class Page1 extends StatefulWidget {
  Page1() {}

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Image.asset('assets/sticklinglogo.png'),
                ),
                Text(
                  'Stickling',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Marko One',
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Just like Tinder but for plants!',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 80,
                right: 80,
              ),
              child: Text(
                'Match with plants nearby to make a trade.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato',
                  color: Colors.grey[600],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Image.asset('assets/page1pic.png'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: RaisedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Page2()),
                ),
                child: Text(
                  'How does it work?',
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
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                ),
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Lato',
                    color: Colors.grey[700],
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
