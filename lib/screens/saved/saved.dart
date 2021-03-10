import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/screens/listing/components/custom_card.dart';
import 'package:napanga/services/auth.dart';
import 'package:napanga/services/repository.dart';
import 'package:napanga/widget/customer_bottom_nav.dart';

import 'components/save_card.dart';

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final int index = 1;
  final _repo = Repository();
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved'),
      ),
      body: Container(
        width: 350,
        margin: EdgeInsets.only(left: 25),
        child: StreamBuilder<QuerySnapshot>(
            stream: _repo.getSaved(_auth.getCurrentUser().uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                return snapshot.data.docs.length > 0
                    ? ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          String category =
                              snapshot.data.docs[index]['category'];
                          String homeId = snapshot.data.docs[index]['home'];

                          return StreamBuilder<DocumentSnapshot>(
                            stream: category == 'apartment'
                                ? _repo.getApt(homeId)
                                : _repo.getHouse(homeId),
                            builder: (context, homeSnapshot) {
                              if (!homeSnapshot.hasData) {
                                return Container();
                              } else {
                                Apartment apartment;
                                House house;
                                if (homeSnapshot.data.reference.path
                                    .startsWith('apartments')) {
                                  apartment = Apartment.fromMap(
                                      homeSnapshot.data.data());
                                  apartment.uid = homeSnapshot.data.id;
                                }
                                if (homeSnapshot.data.reference.path
                                    .startsWith('houses')) {
                                  house =
                                      House.fromMap(homeSnapshot.data.data());
                                  house.uid = homeSnapshot.data.id;
                                }
                                return SavedCard(
                                    apartment: apartment, house: house);
                              }
                            },
                          );
                        },
                      )
                    : Text('Your Saved homes will appear here');
              }
            }),
      ),
      bottomNavigationBar: CustomerBottomNav(
        currentIndex: index,
        newContext: context,
      ),
    );
  }
}
