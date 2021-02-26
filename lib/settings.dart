import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stycling/Registration/Login.dart';
import 'dart:convert';
import 'dart:developer';
class SettingsPage extends StatefulWidget {
  SettingsPage();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class PlantType {
  final int id;
  final String name;

  PlantType({
    this.id,
    this.name,
  });
}

class _SettingsPageState extends State<SettingsPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  List _selectedAnimals= new List();

  @override
  void dispose() {
    confirmPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  double _currentSliderValue = 20;
  String dropdownValue = 'Plant types';
  String _currentSelectedValue;

  static List<PlantType> _tags = [
    PlantType(id: 1, name: 'Monstera'),
    PlantType(id: 2, name: 'Peace Lily'),
    PlantType(id: 3, name: 'Avocado plant'),
    PlantType(id: 4, name: 'Cacti'),
    PlantType(id: 5, name: 'Succulent'),
    PlantType(id: 6, name: 'Aloe vera'),
    PlantType(id: 7, name: 'Pothos'),
    PlantType(id: 8, name: 'Aglaonema'),
    PlantType(id: 9, name: 'Asparagus Fern'),
    PlantType(id: 10, name: 'Calathea'),
  ];

  final _items = _tags
      .map((plantType) => MultiSelectItem<PlantType>(plantType, plantType.name))
      .toList();
  List<PlantType> _selectedPlantTypes = [];
  List<PlantType> _selectedPlantTypes2 = [];
  List<PlantType> _selectedPlantTypes3 = [];
  List<PlantType> _selectedPlantTypes4 = [];
  List<PlantType> _selectedPlantTypes5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  var isEnabled = false;

  @override
  void initState() {
    _selectedPlantTypes5 = _tags;
    // passwordController.addListener(EnableButton);
    // confirmPasswordController.addListener(EnableButton);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Checking State");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 55),
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
                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 100),
                    child: Container(
                      child: Text(
                        'Settings',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 25, right: 25, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            'My current location',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Lato',
                                color: Colors.grey[700]),
                          ),
                          Icon(Icons.near_me_outlined),
                        ],
                      ),
                      Text(
                        'Uppsala',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Lato',
                            color: Colors.grey[600]),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Colors.grey[700]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Max distance',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _currentSliderValue.toStringAsFixed(0) + ' km',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    activeColor: Color(0xFF65C27A),
                    inactiveColor: Colors.grey[400],
                    //label: _currentSliderValue.toStringAsFixed(0),
                    onChanged: (double value) {
                      setState(
                        () {
                          _currentSliderValue = value;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Colors.grey[700]),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                top: 10,
                left: 25,
              ),
              child: Text(
                'I\'m looking for',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  width: MediaQuery.of(context).size.width * 0.95,
                  alignment: Alignment.centerLeft,
                  //width: MediaQuery.of(context).size.width * 0.9,
                  child: MultiSelectChipField(

                    items: _items,

                    scroll: false,
                    onTap: (values) {
                      _selectedAnimals = values;
                      inspect(values);

                      print("Result "+  json.encode(values.toString()));
                    },
                    title: Text("Plant types:"),
                    chipColor: Colors.grey[400],
                    selectedChipColor: Color(0xFF65C27A),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                    headerColor: Colors.white,
                    chipShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Divider(color: Colors.grey[700]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RaisedButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (_) {
                          return MyDialog();
                        }),

                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    color: Color(0xFF65C27A),
                    child: Text(
                      'Change password',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        //fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RaisedButton(
                    // onPressed: () => _onAlertWithCustomContentPressed(context),
                    onPressed: () =>  Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Login()),
            ),

                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    color: Colors.grey,
                    child: Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        //fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Divider(color: Colors.grey[700]),
            ),*/
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  'About',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    //fontWeight: FontWeight.bold,
                    color: Colors.grey,
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

  _onAlertWithCustomContentPressed(context) {
    print("IsEnabled Test" + isEnabled.toString());
    Alert(
        context: context,
        title: "Change password",
        content: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 25, left: 8, right: 8, bottom: 8),
              child: Theme(
                data: ThemeData(primaryColor: Colors.grey),
                child: TextField(
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
                  // onChanged: (text) {
                  //   print("Password changing");
                  //   EnableButton();
                  // },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 2),
              child: Theme(
                data: ThemeData(primaryColor: Colors.grey),
                child: TextField(
                  controller: confirmPasswordController,
                  cursorColor: Colors.grey,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  // onChanged: (text) {
                  //   print("Confirm Password changing");
                  //   EnableButton();
                  // },
                ),
              ),
            ),
          ],
        ),
        buttons: [
          isEnabled
              ? DialogButton(
                  onPressed: isEnabled ? () => Navigator.pop(context) : null,
                  child: Text(
                    "Change password",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Color(0xFF65C27A),
                  radius: BorderRadius.circular(20),
                )
              : DialogButton(
                  onPressed: () => Fluttertoast.showToast(
                      msg: "You password is not matched",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0),
                  child: Text(
                    "Change password",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.grey,
                  radius: BorderRadius.circular(20),
                )
        ]).show();
  }


}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  Color _c = Colors.redAccent;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isEnabled = false;

  EnableButton() {
    print("Text Input 1");
    setState(() {
      isEnabled = true;
      print("Text Input 2");
      if (passwordController.text.length > 0 &&
          confirmPasswordController.text.length > 0 &&
          passwordController.text == confirmPasswordController.text) {
        isEnabled = true;
      } else {
        isEnabled = false;
      }
    });
  }

  @override
  void initState() {
     passwordController.addListener(EnableButton);
     confirmPasswordController.addListener(EnableButton);
  }
  void printObject(Object object) {
    // Encode your object and then decode your object to Map variable
    Map jsonMapped = json.decode(json.encode(object));

    // Using JsonEncoder for spacing
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');

    // encode it to string
    String prettyPrint = encoder.convert(jsonMapped);

    // print or debugPrint your object
    debugPrint(prettyPrint);
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:   Container(
        height: 220,
        child: Column(
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.only(top: 25, left: 8, right: 8, bottom: 8),
              child: Theme(
                data: ThemeData(primaryColor: Colors.grey),
                child: TextField(
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
                  // onChanged: (text) {
                  //   print("Password changing");
                  //   EnableButton();
                  // },
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 2),
              child: Theme(
                data: ThemeData(primaryColor: Colors.grey),
                child: TextField(
                  controller: confirmPasswordController,
                  cursorColor: Colors.grey,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  // onChanged: (text) {
                  //   print("Confirm Password changing");
                  //   EnableButton();
                  // },
                ),
              ),
            ),
            isEnabled
                ? DialogButton(
              onPressed: isEnabled ? () => Navigator.pop(context) : null,
              child: Text(
                "Change password",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Color(0xFF65C27A),
              radius: BorderRadius.circular(20),
            )
                : DialogButton(
              onPressed: () => Fluttertoast.showToast(
                  msg: "You password is not matched",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0),
              child: Text(
                "Change password",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Colors.grey,
              radius: BorderRadius.circular(20),
            )
          ],
        ),
      ),
      actions: <Widget>[

      ],
    );
  }
}
