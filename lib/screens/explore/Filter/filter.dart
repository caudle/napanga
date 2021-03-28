import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:napanga/core/theme.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  RangeValues _currentRangeValues = RangeValues(15, 5000);
  var min;
  var max;



  @override
  Widget build(BuildContext context) {
    List<bool> _selections = List.generate(2, (_) => false);
    if( _currentRangeValues.start.round()>=1000){
      min =  (_currentRangeValues.start.round()/1000).toString() + 'M';
    } else{
      min =  _currentRangeValues.start.round().toString() + 'K';
    }

    if( _currentRangeValues.end.round()>=1000){
      max =  (_currentRangeValues.end.round()/1000).toString() + 'M';
    } else{
      max =  _currentRangeValues.end.round().toString() + 'K';
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 0),
            child: Container(
              margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filters",
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                    children: [
                      Text(
                        "Clear All",
                        textAlign: TextAlign.right,
                      ),
                      Icon(Icons.clear_sharp)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(children: [
        Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Material(
            borderRadius: BorderRadius.circular(6.0),
            elevation: 2.0,
            child: TextField(
              inputFormatters: [LengthLimitingTextInputFormatter(21)],
              decoration: InputDecoration(
                hintText: 'Category,Street,City...',
                hintStyle: TextStyle(fontSize: 14.0, color: AppColor.blueMain),
                prefixIcon: Icon(Icons.search, size: 30),
                contentPadding: EdgeInsets.all(0),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: <Widget>[
              ToggleButtons(
                children: [
                  Container(
                    height: 50,
                    width: (MediaQuery.of(context).size.width / 2) - 20,
                    child: Center(
                      child: Text(
                        'Residential',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    color: AppColor.blueMain,
                  ),
                  Container(
                    height: 50,
                    width: (MediaQuery.of(context).size.width / 2) - 20,
                    child: Center(
                      child: Text(
                        'Commercial',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                ],
                isSelected: _selections,
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 25,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.constColorFont,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Icon(Icons.apartment),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            'Property Type',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 40.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                'Any',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                'Apartment',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                'Entire House',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                'Single Room',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                'Master Room',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                'Hostel',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                'Villa',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                'Bungalow',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                'Town House',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 25,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.constColorFont,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Icon(Icons.king_bed_outlined),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            'Bedrooms',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 40.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                'Any',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                '1',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                '2',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                '3',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                '4',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                '5',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(
                  top: 25,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.constColorFont,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget>[
                        Container(
                          child:Row(
                            children: <Widget>[
                              Icon(Icons.credit_card_sharp),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Price',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Text(min+'-'+ max + '/Month'),
                        )
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 40.0,
                      child: RangeSlider(
                        values: _currentRangeValues,
                        min: 15,
                        max: 5000,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                            if( _currentRangeValues.start.round()>=1000){
                              min =  (_currentRangeValues.start.round()/1000).toString() + 'M';
                            } else{
                              min =  _currentRangeValues.start.round().toString() + 'K';
                            }

                            if( _currentRangeValues.end.round()>=1000){
                              max =  (_currentRangeValues.end.round()/1000).toString() + 'M';
                            } else{
                              max =  _currentRangeValues.end.round().toString() + 'K';
                            }

                          });
                        },
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 25,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.constColorFont,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Icon(Icons.zoom_out_map_sharp),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            'Property Size',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 40.0,
                      child: RangeSlider(
                        values: _currentRangeValues,
                        min: 15,
                        max: 5000,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                          });
                        },
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 25,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.constColorFont,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Icon(Icons.bathtub_sharp),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            'Bathrooms',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 40.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                'Any',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                '1 Bathroom',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                '2 Bathrooms',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                '3 Bathrooms',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                '4 Bathrooms',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                '5 Bathrooms',
                                style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 25,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.constColorFont,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.gem),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            'Amenities',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 40.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                  'Any',
                                  style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                  'A/C',
                                  style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                  'Balcony',
                                  style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                  'Shared Pool',
                                  style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                  'Shared Gym',
                                  style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                  'Private Meter',
                                  style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                  'Parking',
                                  style: Theme.of(context).textTheme.bodyText2
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: AppColor.dSecondaryTextColor)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
