import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/services/repository.dart';

class StatsCard extends StatelessWidget {
  final Apartment apartment;
  final House house;
  StatsCard({@required this.apartment, @required this.house});
  final repo = Repository();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 18, right: 18),
      height: 210,
      child: Material(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(apartment: apartment, house: house),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Row(
                children: [
                  //rating
                  Expanded(
                      child: _buildRating(apartment: apartment, house: house)),
                  //review
                  Expanded(
                      child: _buildReview(
                          apartment: apartment, house: house, repo: repo)),
                  //likes
                  Expanded(
                      child: _buildLikes(
                          apartment: apartment, house: house, repo: repo)),
                ],
              ),
            ),
            _buildViews(apartment: apartment, house: house),
          ],
        ),
      ),
    );
  }
}

Widget _buildTitle({Apartment apartment, House house}) {
  return Container(
    margin: EdgeInsets.only(top: 18, bottom: 10),
    child: Column(
      children: [
        house != null
            ? Container(
                child: Text(house.name),
              )
            : Container(
                child: Text(apartment.building['name']),
              ),
        house == null
            ? Container(
                child: Text(apartment.number),
              )
            : Container(),
      ],
    ),
  );
}

Widget _buildRating({Apartment apartment, House house}) {
  return Container(
    //margin: EdgeInsets.only(left: 10, top: 10, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.star,
              color: kPink,
            ),
            Text(house != null ? house.review ?? '0' : apartment.review ?? '0'),
          ],
        ),
        Text('Rating')
      ],
    ),
  );
}

Widget _buildReview({Apartment apartment, House house, Repository repo}) {
  return Container(
    //margin: EdgeInsets.only(left: 20, top: 10, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: house != null
                ? repo.getHouseReviews(house.uid)
                : repo.getAptReviews(apartment.uid),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? CircularProgressIndicator()
                  : Text(snapshot.data.docs.length.toString());
            }),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text('Reviews'),
        )
      ],
    ),
  );
}

Widget _buildLikes({Apartment apartment, House house, Repository repo}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(house != null ? house.likes ?? '0' : apartment.likes ?? '0'),
      Text('Likes')
    ],
  );
}

Widget _buildViews({Apartment apartment, House house}) {
  return Container(
    margin: EdgeInsets.only(left: 20, top: 20),
    alignment: Alignment.topLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(house != null ? house.views ?? '0' : apartment.views ?? '0'),
        Text('views')
      ],
    ),
  );
}
