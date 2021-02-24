import 'dart:io';
import 'package:stycling/Walkthrough/Page1.dart';
import 'package:stycling/main.dart';
import 'package:stycling/Registration/Signup.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Page2.dart';

class Page3 extends StatefulWidget {
  Page3() {}

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dx > 0) {
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Page1()),
                  );
            }
            // swiping in right direction
            else {
              // swiping in left direction
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Page3()),
                  );
            }
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 70),
                    child: Text(
                      'How Stickling works?',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
