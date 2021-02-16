import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'CameraPicker.dart';

class PlantProfile extends StatefulWidget {
  File imageFile;
  PlantProfile(File imageFile) {
    this.imageFile = imageFile;
  }

  @override
  _PlantProfileState createState() => _PlantProfileState();
}

class _PlantProfileState extends State<PlantProfile> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  File _imageFile;

  var isEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 55, left: 10, right: 30),
                    child: TextField(
                      textDirection: TextDirection.ltr,
                      controller: titleController,
                      style: TextStyle(fontSize: 30),
                      cursorColor: Colors.black,
                      showCursor: false,
                      onChanged: (text) {
                        EnableButton();
                      },
                      //enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        fillColor: Color(0xFF65C27A),
                        border: InputBorder.none,
                        prefixIcon:
                            Icon(Icons.edit, color: Colors.grey, size: 25),
                        hintText: 'Title',
                        alignLabelWithHint: true,
                        hintStyle: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                ),
                widget.imageFile == null
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          CaptureImage();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 48.0, right: 20),
                          child: Icon(
                            Icons.control_point_outlined,
                            size: 60,
                            color: Color(0xFF000000).withOpacity(0.1),
                          ),
                        ),
                      ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: widget.imageFile == null
                      ? Container(
                          height: 375,
                          width: 375,
                          child: GestureDetector(
                            onTap: () {
                              CaptureImage();
                            },
                            child: Icon(
                              Icons.control_point_outlined,
                              size: 80,
                              color: Color(0xFF000000).withOpacity(0.1),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9).withOpacity(.5),
                              borderRadius: BorderRadius.circular(10)),
                        )
                      : Container(
                          height: 375,
                          width: 375,
                          decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9).withOpacity(.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.file(
                              widget.imageFile,
                              fit: BoxFit.fitWidth,
                            ),
                          )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.top,
                      controller: descriptionController,
                      maxLines: 5,
                      onChanged: (text) {
                        EnableButton();
                      },
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: 'Describe your plant...',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFD9D9D9).withOpacity(.5),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF000000).withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: RaisedButton(
                    onPressed: isEnabled ? () => Navigator.pop : null,
                    child: Text(
                      'Upload plant',
                      style: TextStyle(fontSize: 25),
                    ),
                    textColor: Colors.white,

                    //disabledTextColor: Colors.white,
                    color: Colors.pinkAccent,

                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  CaptureImage() {
    Alert(
      context: context,
      title: "Choose Image",
      desc: "Choose image for your plant",
      buttons: [
        DialogButton(
          child: Text(
            "Gallery",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => captureImage(ImageSource.gallery),
          color: Color(0xFF65C27A),
        ),
        DialogButton(
          child: Text(
            "Camera",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => captureImage(ImageSource.camera),
          color: Color(0xFF65C27A),
        ),
      ],
    ).show();
  }

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlantProfile(imageFile)),
      );
    } catch (e) {
      print(e);
    }
  }

  EnableButton() {
    print("Text1 " + descriptionController.text.length.toString());
    print("Text2 " + titleController.text.length.toString());
    setState(() {
      if (widget.imageFile == null) {
        isEnabled = false;
      } else {
        if (descriptionController.text.length > 0 &&
            titleController.text.length > 0) {
          isEnabled = true;
        } else {
          isEnabled = false;
        }
      }
    });

    print("IsEnables " + isEnabled.toString());
  }
}
