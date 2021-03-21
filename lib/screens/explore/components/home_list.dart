import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/widget/home_card.dart';

class HomeList extends StatelessWidget {
  final List<DocumentSnapshot> homeDocs;

  HomeList({@required this.homeDocs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeDocs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Apartment apartment;
          House house;

          //check if doc is apartment or house
          if (homeDocs.isNotEmpty) {
            if (homeDocs[index].reference.path.startsWith('apartments')) {
              apartment = Apartment.fromMap(homeDocs[index].data());
              apartment.uid = homeDocs[index].id;
            } else if (homeDocs[index].reference.path.startsWith('houses')) {
              house = House.fromMap(homeDocs[index].data());
              house.uid = homeDocs[index].id;
            }
          } else {
            apartment = null;
            house = null;
          }
          return HomeCard(
            apartment: apartment,
            house: house,
            tap: true,
            index: index,
          );
        });
  }
}
