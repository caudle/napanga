import 'package:flutter/material.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/screens/listing/components/custom_card.dart';
import 'package:napanga/widget/video_widget.dart';
import 'package:video_player/video_player.dart';

class View extends StatefulWidget {
  @override
  _ViewState createState() => _ViewState();
  final Apartment apartment;
  final House house;
  View({@required this.apartment, @required this.house});
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    //final List<CustomCard> aptCards =
    //widget.apartment.images.map((image) => CustomCard(apartment: widget.apartment, house: house)).toList();
    return Scaffold(
      body: ListView(
        children: [
          _buildTopBar(),
          widget.apartment != null
              ? _buildRow(
                  title: 'Building name',
                  value: widget.apartment.building['name'])
              : Container(),
          widget.apartment != null
              ? _buildRow(
                  title: 'Number of units',
                  value: widget.apartment.building['units'])
              : Container(),
          widget.apartment != null
              ? _buildRow(
                  title: 'Apartment number', value: widget.apartment.number)
              : _buildRow(title: 'House name', value: widget.house.name),
          _buildRow(
              title: 'Hosted since',
              value: widget.apartment != null
                  ? widget.apartment.date.toString()
                  : widget.house.date.toString()),
          _buildRow(
              title: 'Number of bedrooms',
              value: widget.apartment != null
                  ? widget.apartment.bedrooms.toString()
                  : widget.house.bedrooms.toString()),
          _buildRow(
              title: 'Number of bathrooms',
              value: widget.apartment != null
                  ? widget.apartment.bathrooms.toString()
                  : widget.house.bathrooms.toString()),
          Container(
            margin: EdgeInsets.only(left: 18, top: 20),
            child: Text('Description'),
          ),
          Container(
            margin: EdgeInsets.only(left: 18, top: 20),
            child: Text(widget.apartment != null
                ? widget.apartment.description
                : widget.house.description),
          ),
          //images
          Container(
            margin: EdgeInsets.only(left: 18, top: 20, bottom: 10),
            child: Text('Images'),
          ),
          _buildGrid(),
          //videos
          Container(
            margin: EdgeInsets.only(left: 18, top: 20, bottom: 10),
            child: Text('Videos'),
          ),
          Container(
            height: 200,
            width: 150,
            margin: EdgeInsets.only(left: 18, top: 20, bottom: 10),
            child: Material(
              child: VideoWidget(
                  videoPlayerController: VideoPlayerController.network(
                      widget.apartment != null
                          ? widget.apartment.videos[0]
                          : widget.house.videos[0])),
            ),
          ),
          //loaction
          Container(
            margin: EdgeInsets.only(
              left: 18,
              top: 20,
            ),
            child: Text('Location'),
          ),
          _buildRow(
              title: 'Country',
              value: widget.apartment != null
                  ? widget.apartment.location['country']
                  : widget.house.location['country']),
          _buildRow(
              title: 'City/Region',
              value: widget.apartment != null
                  ? widget.apartment.location['city']
                  : widget.house.location['city']),
          _buildRow(
              title: 'District',
              value: widget.apartment != null
                  ? widget.apartment.location['district']
                  : widget.house.location['district']),
          _buildRow(
              title: 'Street',
              value: widget.apartment != null
                  ? widget.apartment.location['street']
                  : widget.house.location['street']),
          //amenities
          Container(
            margin: EdgeInsets.only(
              left: 18,
              top: 20,
              bottom: 10,
            ),
            child: Text('Amenities'),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 18,
            ),
            child: Row(
              children: widget.apartment != null
                  ? widget.apartment.amenities
                      .map((amenity) => Expanded(
                          child: amenity != null ? Text(amenity) : Container()))
                      .toList()
                  : widget.house.amenities
                      .map((amenity) => Expanded(
                          child: amenity != null ? Text(amenity) : Container()))
                      .toList(),
            ),
          ),
          //price
          Container(
            margin: EdgeInsets.only(
              left: 18,
              top: 20,
            ),
            child: Text('Pricing'),
          ),
          _buildRow(
              title: 'Rent per month in Tsh',
              value: widget.apartment != null
                  ? widget.apartment.price.toString()
                  : widget.house.price.toString()),
          _buildRow(
              title: 'Number of terms',
              value: widget.apartment != null
                  ? widget.apartment.terms.toString()
                  : widget.house.toString()),
          _buildRow(
              title: 'Dalali fee',
              value: widget.apartment != null
                  ? widget.apartment.fee.toString()
                  : widget.house.fee.toString()),
          Padding(padding: EdgeInsets.only(top: 20))
        ],
      ),
    );
  }

  //top
  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          //margin: EdgeInsets.only(top: 30),
          child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.only(top: 100),
            child: Text(
              widget.apartment != null ? 'Apartment details' : 'House details',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 18),
          child: GestureDetector(
            onTap: () {},
            child: Text('Save'),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 18),
          child: GestureDetector(
            child: Text('Delete'),
          ),
        )
      ],
    );
  }

  Widget _buildRow({String title, String value}) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 18, top: 20),
            child: Text(title),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 18, top: 20),
            child: Text(value),
          ),
        )
      ],
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
        padding: EdgeInsets.only(left: 18, right: 10),
        shrinkWrap: true,
        itemCount: widget.apartment != null
            ? widget.apartment.images.length
            : widget.house.images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          return Material(
            child: Container(
              child: Image.network(
                widget.apartment == null
                    ? widget.house.images[index]
                    : widget.apartment.images[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }
}
