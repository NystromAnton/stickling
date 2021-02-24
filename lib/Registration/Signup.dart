import 'dart:convert';
import 'dart:io';
import 'package:stycling/main.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
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
  @override
  void dispose() {
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }
void callApis(){
Map<String, String> user = {"name": "John Doe",
 "email": "a@b.com",
 "password": "123456",
 "location": "[23, 43]",
 };
String userJson = jsonEncode(user);


  http.post("http://localhost:3000/users/signup",
  headers: {"Content-Type": "application/json"},
      body: userJson).then((result){
    int itemId = json.decode(result.body);
    print(itemId.toString());

  });
}
  var isEnabled = false;
  void initState() {
    super.initState();
    callApis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(children: [
              Container(
                  padding: const EdgeInsets.only(top: 55),
                  child: GestureDetector(
                    onTap: (){
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
            ],),
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
                      onPressed: isEnabled
                          ? () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TabBarDemo()),
                              )
                          : null,
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
}
