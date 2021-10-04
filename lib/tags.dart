import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stycling/Profile/EditProfile.dart';
import 'package:stycling/settings.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Profile/ProfilePage.dart';
import 'settings.dart';

class Tags extends StatefulWidget {

  @override
  _TagsState createState() => _TagsState();
}

class PlantType {
  final int id;
  final String name;

  PlantType({
    this.id,
    this.name,
  });
}

class _TagsState extends State<Tags> {
List _selectedAnimals= new List();

  @override
  void dispose() {
    super.dispose();
  }


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

    @override
  void initState() {
    _selectedPlantTypes5 = _tags;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            child: MultiSelectChipField(
                    items: _items,
                    scroll: false,
                    onTap: (values) {
                      _selectedAnimals = values;
                      inspect(values);
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
          )],
        )
        )
      );
  }
}
