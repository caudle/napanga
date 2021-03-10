import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/services/auth.dart';
import 'package:napanga/services/repository.dart';

class HomeCard extends StatefulWidget {
  final Apartment apartment;
  final House house;
  final bool tap;
  HomeCard(
      {@required this.apartment, @required this.house, @required this.tap});

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200,
      //width: 250,
      child: Material(
        //elevation: 6,
        //margin: EdgeInsets.only(left: 9, right: 1)
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image stack
              _buildImageStack(
                apartment: widget.apartment,
                house: widget.house,
              ),
              //star row
              _buildStarRow(apartment: widget.apartment, house: widget.house),
              //district
              _buildDistrict(apartment: widget.apartment, house: widget.house),
              //home name
              _buildName(apartment: widget.apartment, house: widget.house),
            ],
          ),
          onTap: widget.tap
              ? () {
                  Navigator.pushNamed(context, '/details', arguments: {
                    'apartment': widget.apartment,
                    'house': widget.house
                  });
                }
              : null,
        ),
      ),
      margin: EdgeInsets.only(top: 3, bottom: 5, left: 0, right: 10),
    );
  }
}

//image stack
Widget _buildImageStack({
  @required Apartment apartment,
  @required House house,
}) {
  final repo = Repository();
  return Stack(
    children: [
      Container(
        width: 250,
        height: 150,
        child: Image.network(
          apartment == null ? house.images[0] : apartment.images[0],
          fit: BoxFit.fitWidth,
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
    ],
  );
}

//star row
Widget _buildStarRow({@required Apartment apartment, @required House house}) {
  return Container(
    padding: EdgeInsets.only(
      left: 5,
      top: 8,
      right: 5,
      bottom: 2,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          flex: 2,
          child: Text(
            apartment == null ? 'House' : 'Apartment',
            style: TextStyle(color: Colors.black45),
          ),
        ),
        //apartment == null ? SizedBox(width: 139) : SizedBox(width: 130),
        Flexible(
            fit: FlexFit.loose,
            child: SizedBox(
              width: apartment == null ? 163 : 135,
            )),
        Flexible(
          flex: 2,
          fit: FlexFit.loose,
          child: Icon(
            Icons.star,
            color: kPink,
            size: 14,
          ),
        ),
        Flexible(
          flex: 5,
          fit: FlexFit.loose,
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
