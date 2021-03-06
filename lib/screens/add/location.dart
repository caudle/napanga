import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/screens/add/amenities.dart';

class LocationWidget extends StatefulWidget {
  @override
  _LocationWidgetState createState() => _LocationWidgetState();
  final Apartment apartment;
  final House house;
  LocationWidget({@required this.apartment, @required this.house});
}

class _LocationWidgetState extends State<LocationWidget> {
  TextEditingController countryController =
      TextEditingController(text: 'Tanzania');
  TextEditingController cityController =
      TextEditingController(text: 'Dar es Salaam');
  TextEditingController districtController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  bool city = false;
  bool beach = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            //country
            Container(
              margin: EdgeInsets.only(top: 70, left: 18),
              child: Text('Country'),
            ),
            Container(
                margin: EdgeInsets.only(left: 18, right: 50),
                child: TextFormField(
                  readOnly: true,
                  controller: countryController,
                )),

            //city
            Container(
              margin: EdgeInsets.only(left: 18, top: 20),
              child: Text('Region/City'),
            ),
            Container(
                margin: EdgeInsets.only(left: 18, right: 50),
                child: TextFormField(
                  readOnly: true,
                  controller: cityController,
                )),

            //district
            Container(
              margin: EdgeInsets.only(left: 18, top: 20),
              child: Text('District'),
            ),
            Container(
                margin: EdgeInsets.only(left: 18, right: 50),
                child: TextFormField(
                  controller: districtController,
                  decoration: InputDecoration(hintText: 'eg: Kinondoni'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'enter district';
                    }
                    return null;
                  },
                )),
            //street
            Container(
              margin: EdgeInsets.only(left: 18, top: 20),
              child: Text('Street'),
            ),
            Container(
                margin: EdgeInsets.only(left: 18, right: 50),
                child: TextFormField(
                  controller: streetController,
                  decoration: InputDecoration(hintText: 'eg: alimaua'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'enter street';
                    }
                    return null;
                  },
                )),
            //category of the loc
            Container(
              margin: EdgeInsets.only(left: 18, top: 20),
              child: Text('Where is your place located'),
            ),
            //parking
            CheckboxListTile(
              title: Text('In the city'),
              value: city,
              onChanged: (value) {
                setState(() {
                  city = value;
                });
              },
              contentPadding: EdgeInsets.only(left: 18, top: 30, right: 18),
            ),
            //wifi
            CheckboxListTile(
              title: Text('Near the beach'),
              value: beach,
              onChanged: (value) {
                setState(() {
                  beach = value;
                });
              },
              contentPadding: EdgeInsets.only(left: 18, right: 18),
            ),
            //next
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(top: 70, right: 10),
                width: 100,
                child: RaisedButton(
                  child: Text(
                    'Next',
                    style: TextStyle(color: kWhite),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (widget.apartment != null) {
                        widget.apartment.location = {
                          'country': countryController.value.text,
                          'city': cityController.value.text,
                          'district': districtController.value.text,
                          'street': streetController.value.text
                        };
                        widget.apartment.category = {
                          'city': city,
                          'beach': beach
                        };

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Amenities(
                              apartment: widget.apartment, house: null);
                        }));
                      } else {
                        widget.house.location = {
                          'country': countryController.value.text,
                          'city': cityController.value.text,
                          'district': districtController.value.text,
                          'street': streetController.value.text
                        };
                        widget.house.category = {'city': city, 'beach': beach};
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Amenities(
                              apartment: null, house: widget.house);
                        }));
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: kPink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
