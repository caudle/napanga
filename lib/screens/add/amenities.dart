import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/screens/add/price.dart';
import 'package:napanga/services/blocs/listing/listing_bloc.dart';

class Amenities extends StatefulWidget {
  @override
  _AmenitiesState createState() => _AmenitiesState();
  final Apartment apartment;
  final House house;
  Amenities({@required this.apartment, @required this.house});
}

class _AmenitiesState extends State<Amenities> {
  TextEditingController descController = TextEditingController();
  bool parking = false;
  bool wifi = false;
  bool ac = false;
  final _formKey = GlobalKey<FormState>();
  List amenities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amenities'),
      ),
      body: ListView(
        children: [
          //parking
          CheckboxListTile(
            title: Text('Car parking on premises'),
            value: parking,
            onChanged: (value) {
              setState(() {
                parking = value;
              });
            },
            contentPadding: EdgeInsets.only(left: 18, top: 30, right: 18),
          ),
          //wifi
          CheckboxListTile(
            title: Text('Wifi'),
            value: wifi,
            onChanged: (value) {
              setState(() {
                wifi = value;
              });
            },
            contentPadding: EdgeInsets.only(left: 18, right: 18),
          ),
          //ac
          CheckboxListTile(
            title: Text('Air conditioner'),
            value: ac,
            onChanged: (value) {
              setState(() {
                ac = value;
              });
            },
            contentPadding: EdgeInsets.only(left: 18, right: 18),
          ),
          //desc
          Container(
            margin: EdgeInsets.only(left: 18, top: 10),
            child: Text('Description'),
          ),

          Container(
            margin: EdgeInsets.only(left: 18, top: 15, right: 18),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: descController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Tell us about your place,what makes it unique',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'enter description';
                  }
                  return null;
                },
              ),
            ),
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
                      widget.apartment.amenities = [
                        parking ? 'Car parking on premises' : null,
                        wifi ? 'WiFi' : null,
                        ac ? 'Air Conditioner' : null
                      ];
                      widget.apartment.description = descController.value.text;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocProvider(
                          create: (context) => ListingBloc(),
                          child: PriceWidget(
                              apartment: widget.apartment, house: null),
                        );
                      }));
                    } else {
                      widget.house.amenities = [
                        parking ? 'Car parking on premises' : null,
                        wifi ? 'WiFi' : null,
                        ac ? 'Air Conditioner' : null
                      ];
                      widget.house.description = descController.value.text;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocProvider(
                          create: (context) => ListingBloc(),
                          child:
                              PriceWidget(apartment: null, house: widget.house),
                        );
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
    );
  }
}
