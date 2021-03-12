import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/services/repository.dart';

class SavedCard extends StatelessWidget {
  final Apartment apartment;
  final House house;
  SavedCard({@required this.apartment, @required this.house});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      height: 240,
      child: Material(
        elevation: 2,
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image
              _buildImage(apartment: apartment, house: house),
              //star row
              _buildStar(apartment: apartment, house: house),
              //district
              _buildDistrict(apartment: apartment, house: house),
              _buildName(apartment: apartment, house: house)
              //name
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}

//image
Widget _buildImage({@required Apartment apartment, House house}) {
  final repo = Repository();
  return Stack(children: [
    Container(
      width: 350,
      height: 150,
      child: Image.network(
        apartment == null ? house.images[0] : apartment.images[0],
        fit: BoxFit.cover,
      ),
    ),
    Positioned(
      right: 0,
      child: Stack(
        children: [
          Positioned(
            top: 7,
            left: 8.7,
            child: Container(
                width: 30,
                height: 30,
                decoration:
                    BoxDecoration(color: kWhite, shape: BoxShape.circle)),
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: repo.checkSaved(
                  userId: repo.getUserId(),
                  homeId: house != null ? house.uid : apartment.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  return IconButton(
                      icon: Icon(
                        snapshot.data.exists
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: kPink,
                      ),
                      onPressed: () {
                        _onPressed(
                            userId: repo.getUserId(),
                            homeId: house != null ? house.uid : apartment.uid,
                            category: house != null ? 'house' : 'apartment',
                            saved: snapshot.data.exists,
                            repo: repo);
                      });
                }
              }),
        ],
      ),
    )
  ]);
}

//star row
Widget _buildStar({@required Apartment apartment, House house}) {
  return Container(
    padding: EdgeInsets.only(
      left: 5,
      top: 20,
      right: 5,
      bottom: 2,
    ),
    child: Row(
      //mainAxisAlignment: MainAxis,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            apartment == null ? 'House' : 'Apartment',
            style: TextStyle(color: Colors.black45),
          ),
        ),
        //apartment == null ? SizedBox(width: 139) : SizedBox(width: 130),
        Expanded(
          child: Icon(
            Icons.star,
            color: kPink,
            size: 14,
          ),
        ),
        Expanded(
          child: Text(
            apartment == null
                ? house.review.toString()
                : apartment.review.toString(),
          ),
        ),
      ],
    ),
  );
}

//district
Widget _buildDistrict({@required Apartment apartment, @required House house}) {
  return Container(
    padding: EdgeInsets.only(bottom: 2, left: 5),
    child: Text(
      apartment == null
          ? house.location['district']
          : apartment.location['district'],
      style: TextStyle(color: Colors.black45),
    ),
  );
}

//name
Widget _buildName({@required Apartment apartment, @required House house}) {
  return Container(
    padding: EdgeInsets.only(bottom: 0, left: 5),
    child: Text(
      apartment == null ? house.name : apartment.number,
      // style: TextStyle(color: Colors.black87),
    ),
  );
}

_onPressed(
    {String homeId,
    String userId,
    String category,
    bool saved,
    Repository repo}) {
  if (saved) {
    repo.deleteSaved(userId: userId, homeId: homeId);
  } else {
    repo.createSaved(user: userId, home: homeId, category: category);
  }
}
