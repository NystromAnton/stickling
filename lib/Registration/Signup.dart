import 'dart:convert';
import 'dart:io';
import 'package:stycling/Registration/Login.dart';
import 'package:stycling/main.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class Signup extends StatefulWidget {
  Signup() {}

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  double long;
  double lat;
  var currentPos = [];

  @override
  void dispose() {
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<String> requestMethod(String url) async {
    _determinePosition().then((value) {
      long = value.longitude;
      lat = value.latitude;
      currentPos = [long, lat];
    });

    

    var body = json.encode({
      "name": firstnameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "location": {"type": "Point", "coordinates": currentPos}
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(url, body: body, headers: headers);
    final responseJson = response.body.toString();
    return responseJson;
  }

  // var isEnabled = false;
  String url = 'https://sticklingar.herokuapp.com/users/signup';
  // Map map =
  // };
  var isEnabled = false;

  @override
  void initState() {
    url = "https://sticklingar.herokuapp.com/users/signup";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 55),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded),
                      onPressed: null,
                      iconSize: 35,
                      color: Color(0xFF65C27A),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
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
                    'Sign up',
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
                          controller: firstnameController,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            labelText: 'First name',
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
              padding: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Theme(
                        data: ThemeData(primaryColor: Colors.grey),
                        child: TextFormField(
                          controller: lastnameController,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            labelText: 'Last name',
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
              padding: EdgeInsets.only(top: 15),
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
              padding: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Theme(
                        data: ThemeData(primaryColor: Colors.grey),
                        child: TextFormField(
                          controller: confirmPasswordController,
                          cursorColor: Colors.grey,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
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
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 0,
                    child: RaisedButton(
                      onPressed: isEnabled ? () => CheckRegistration() : null,
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 25),
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
            ),
          ],
        ),
      ),
    );
  }

  EnableButton() {
    setState(() {
      if (emailController.text.length > 0 &&
          passwordController.text.length > 0 &&
          firstnameController.text.length > 0 &&
          lastnameController.text.length > 0 &&
          confirmPasswordController.text.length > 0 &&
          passwordController.text == confirmPasswordController.text) {
        isEnabled = true;
      } else {
        isEnabled = false;
      }
    });
  }

  CheckRegistration() {
    requestMethod(url).then((value) {
      //print("Result " + value);
      if (value != "user posted") {
        Fluttertoast.showToast(
            msg: value,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });
  }
}
