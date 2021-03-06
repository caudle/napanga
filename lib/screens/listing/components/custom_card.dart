import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/screens/listing/components/view.dart';

//card to display a listing info
class CustomCard extends StatefulWidget {
  @override
  _CustomCardState createState() => _CustomCardState();
  final Apartment apartment;
  final House house;
  CustomCard({@required this.apartment, @required this.house});
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 3, bottom: 5, left: 0, right: 10),
      child: Material(
        //elevation: 12,
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image
              _buildImage(apartment: widget.apartment, house: widget.house),
              //star row
              _buildStar(apartment: widget.apartment, house: widget.house),
              //district
              _buildDistrict(apartment: widget.apartment, house: widget.house),
              _buildName(apartment: widget.apartment, house: widget.house)
              //name
            ],
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return View(
                apartment: widget.apartment,
                house: widget.house,
              );
            }));
          },
        ),
      ),
    );
  }
}

//image
Widget _buildImage({@required Apartment apartment, House house}) {
  return Container(
    height: 120,
    width: 250,
    child: Image.network(
      apartment == null ? house.images[0] : apartment.images[0],
      fit: BoxFit.fitWidth,
    ),
  );
}

//star row
Widget _buildStar({@required Apartment apartment, House house}) {
  return Container(
    padding: EdgeInsets.only(
      left: 5,
      top: 8,
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
