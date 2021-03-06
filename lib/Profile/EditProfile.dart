import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stycling/Profile/ProfilePage.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  List<dynamic> images;
  String title;
  String description;

  EditProfile(List images, String title, String description) {
    this.images = images;
    this.title = title;
    this.description = description;
  }

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  List _imageFile;
  //List<Asset> images = List<Asset>();
  String _error = 'No Error Detected';
  Asset asset = null;
  Asset asset_one = null;
  var isEnabled = false;
  List<Widget> images_Asscets = List<Widget>();

  @override
  void initState() {
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    print("test: " + widget.images.toString());
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
                      showCursor: true,
                      onChanged: (text) {
                        EnableButton();
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xFF65C27A),
                        border: InputBorder.none,
                        prefixIcon:
                            Icon(Icons.edit, color: Colors.grey, size: 25),
                        hintText: titleController.text,
                        alignLabelWithHint: true,
                        hintStyle: TextStyle(
                          fontSize: 35,
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
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 1,
                        child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.images.length + 1,
                        itemBuilder: (context, i){
                          if (i == 0) {
                            print("images: " + widget.images.toString());
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.height * 0.25,
                          child: GestureDetector(
                              onTap: () {
                                loadAssets();
                              },
                              child: Icon(
                                Icons.control_point_outlined,
                                size: MediaQuery.of(context).size.height * 0.08,
                                color: Color(0xFF000000).withOpacity(0.1),
                              ),
                          ),
                          decoration: BoxDecoration(
                                color: Color(0xFFD9D9D9).withOpacity(.5),
                                borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                            } else {
                              return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.height * 0.25,
                              child: ClipRRect( borderRadius:  BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                  //width: (MediaQuery.of(context).size.height * 0.5).toInt(),
                                  //height: (MediaQuery.of(context).size.height * 0.5).toInt(),
                                 //width: 500,
                                 //height: 500,
                                 // asset: widget.images[i-1]
                                 imageUrl: widget.images[i-1],
                                 fit: BoxFit.cover,
                                 ),
                              ),
                            )
                          );
                            }
                        })
                          /*height: MediaQuery.of(context).size.height * 0.40,
                          width: MediaQuery.of(context).size.width * 0.98,
                          child: Carousel(
                            images: images_Asscets,
                            dotSize: 4,
                            dotBgColor: Colors.transparent,
                            dotSpacing: 15,
                            autoplay: false,
                          ),*/
                ),
                  /*SizedBox(
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: MediaQuery.of(context).size.width * 0.98,
                      child: CachedNetworkImage(
                        imageUrl: widget.imageFile,
                        fit: BoxFit.cover,
                      )
                      /*Carousel(
                      images: images_Asscets,
                      dotSize: 4,
                      dotBgColor: Colors.transparent,
                      dotSpacing: 15,
                      autoplay: false,
                      ),*/
                      ),*/
                  // : Container(
                  //     height: 375,
                  //     width: 375,
                  //     decoration: BoxDecoration(
                  //         color: Color(0xFFD9D9D9).withOpacity(.5),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //       child: Image.file(
                  //         widget.imageFile,
                  //         fit: BoxFit.cover,
                  //       ),
                  //     )),
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
                        labelText: descriptionController.text,
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
                    color: Color(0xFF65C27A),

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

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: widget.images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      widget.images = resultList;
      print("images Size " + widget.images.length.toString());

      for (int i = 0; i < widget.images.length; i++) {
        Asset asset = widget.images[i];
        asset = widget.images[0];

        images_Asscets.add(AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        ));
      }
      _error = error;
    });
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

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PlantProfile(imageFile)),
      // );
    } catch (e) {}
  }

  EnableButton() {
    setState(() {
      if (widget.images == null) {
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
  }
}
