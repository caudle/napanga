import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/screens/add/aptView.dart';
import 'package:napanga/screens/add/houseView.dart';
import 'package:napanga/screens/add/media.dart';

class AddListing extends StatefulWidget {
  @override
  _AddListingState createState() => _AddListingState();
}

class _AddListingState extends State<AddListing> {
  Apartment apartment = Apartment();
  House house = House();
  TextEditingController bNameController = TextEditingController();
  TextEditingController unitsController = TextEditingController();
  TextEditingController aptNoController = TextEditingController();
  TextEditingController bedController = TextEditingController();
  TextEditingController bathController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController hBathController = TextEditingController();
  TextEditingController hBedController = TextEditingController();

  final List<String> houses = <String>['apartment', 'house'];

  List<DropdownMenuItem> items = <DropdownMenuItem>[
    DropdownMenuItem(
      child: Text('Apartment'),
      value: 'apartment',
    ),
    DropdownMenuItem(
      child: Text('House'),
      value: 'house',
    ),
  ];

  String dropdownValue = 'apartment';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add listing'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 18, top: 20, bottom: 10),
            child: Text('Property details'),
          ),
          Row(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 18, bottom: 10, top: 10, right: 20),
                child: Text('Category'),
              ),
              DropdownButton(
                  value: dropdownValue,
                  items: items,
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  }),
            ],
          ),
          //apartment detail
          dropdownValue == 'apartment'
              ? apartmentView(
                  context: context,
                  bname: bNameController,
                  units: unitsController,
                  aptNo: aptNoController,
                  bedroom: bedController,
                  bathroom: bathController,
                  key: _formKey,
                  apartment: apartment,
                )
              : houseView(
                  context: context,
                  key: _formKey,
                  name: nameController,
                  bedroom: hBedController,
                  bathroom: hBathController,
                  house: house,
                ),
        ],
      ),
    );
  }
}
