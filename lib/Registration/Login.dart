import 'dart:io';
import 'package:stycling/main.dart';
import 'Signup.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class Login extends StatefulWidget {
  Login() {}

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<Position> coordinates;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<String> requestMethod(String url) async {
    var body = json.encode({
      "email": emailController.text,
      "password": passwordController.text,
    });
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(url, body: body, headers: headers);
    final responseJson = response.body.toString();

    return responseJson;
  }

  String url = 'http://localhost:3000/users/login';

  var isEnabled = false;

  @override
  void initState() {
    url = "https://sticklingar.herokuapp.com/users/login";
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
                  child: Image.asset('assets/stickling_heart_logo.png',
                      height: 50),
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
              padding: const EdgeInsets.only(top: 90.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Log in',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato'),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Theme(
                        data: ThemeData(primaryColor: Colors.grey),
                        child: TextFormField(
                          controller: emailController,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            //hintText: 'first.lastname@email.com',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (text) {
                            EnableButton();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Theme(
                        data: ThemeData(primaryColor: Colors.grey),
                        child: TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.grey,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (text) {
                            EnableButton();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            decoration: TextDecoration.underline, fontSize: 14),
                      ),
                      onTap: null)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 0,
                  child: RaisedButton(
                    onPressed: isEnabled ? () => ValidateUser() : null,
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Lato',
                      ),
                    ),
                    textColor: Colors.white,
                    color: Color(0xFF65C27A),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'or',
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    ),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 25,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'About',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  EnableButton() {
    setState(() {
      if (emailController.text.length > 0 &&
          passwordController.text.length > 0) {
        isEnabled = true;
      } else {
        isEnabled = false;
      }
    });
  }

  ValidateUser() {
    requestMethod(url).then((value) {
      //print("Result " + value);
      if (value == "login failed") {
        Fluttertoast.showToast(
            msg: value,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        if (value == "Email and password doesn't match") {
          Fluttertoast.showToast(
              msg: value,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          String newvalue = value.substring(1, value.length - 1);
          //print("NewValue " + newvalue);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TabBarDemo(newvalue)),
          );
        }
      }
    });
  }
}
