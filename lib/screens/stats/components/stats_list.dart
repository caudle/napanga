import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/screens/stats/components/stats_card.dart';

class StatsList extends StatelessWidget {
  final List<DocumentSnapshot> homeDocs;

  StatsList({@required this.homeDocs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
          return StatsCard(apartment: apartment, house: house);
        });
  }
}
