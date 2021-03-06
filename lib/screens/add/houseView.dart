import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/services/blocs/listing/listing_bloc.dart';

import 'media.dart';

Widget houseView(
    {@required BuildContext context,
    TextEditingController name,
    TextEditingController bedroom,
    TextEditingController bathroom,
    GlobalKey<FormState> key,
    House house}) {
  return Form(
    key: key,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 18, right: 5, bottom: 10),
          child: Text(
              """Apartments are typically located in multi-unit residential buildings where people live"""),
        ),
        //building name
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 18, right: 18, top: 10),
              child: Text('House name'),
            ),
            Container(
              padding: EdgeInsets.only(left: 18, right: 5, top: 10),
              width: 200,
              height: 40,
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'enter name';
                  }
                  return null;
                },
              ),
            )
          ],
        ),

        //room details
        Container(
          margin: EdgeInsets.only(left: 18, top: 30),
          child: Text('Room details'),
        ),
        //bedroom
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 18, right: 18, top: 10),
              child: Text('Number of bedrooms'),
            ),
            Container(
              margin: EdgeInsets.only(left: 18, right: 15, top: 10),
              width: 50,
              height: 30,
              child: TextFormField(
                controller: bedroom,
                decoration: InputDecoration(
                  labelText: '0',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'enter number';
                  }
                  return null;
                },
              ),
            )
          ],
        ),
        //bathroom
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 18, right: 18, top: 10),
              child: Text('Number of bathrooms'),
            ),
            Container(
              margin: EdgeInsets.only(left: 18, right: 15, top: 10),
              width: 50,
              height: 30,
              child: TextFormField(
                controller: bathroom,
                decoration: InputDecoration(
                  labelText: '0',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'enter number';
                  }
                  return null;
                },
              ),
            )
          ],
        ),
        //next
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.only(top: 30, right: 10),
            width: 70,
            child: RaisedButton(
              child: Text(
                'Next',
                style: TextStyle(color: kWhite),
              ),
              onPressed: () {
                if (key.currentState.validate()) {
                  house.name = name.value.text;
                  house.bedrooms = int.parse(bedroom.value.text);
                  house.bathrooms = int.parse(bathroom.value.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                      create: (context) => ListingBloc(),
                      child: ListingMedia(
                        apartment: null,
                        house: house,
                      ),
                    );
                  }));
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
