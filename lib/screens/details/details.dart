import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/models/review.dart';
import 'package:napanga/models/user.dart';
import 'package:napanga/services/blocs/explore/explore_bloc.dart';
import 'package:napanga/utils/calc_review.dart';
import 'package:napanga/widget/video_widget.dart';
import 'package:video_player/video_player.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
  final Apartment apartment;
  final House house;
  Details({@required this.apartment, @required this.house});
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final exploreBloc = BlocProvider.of<ExploreBloc>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 6,
            floating: true,
            snap: true,
            iconTheme: IconThemeData(color: kGreen),
            backgroundColor: kWhite,
            flexibleSpace: FlexibleSpaceBar(
              background: VideoWidget(
                  isLooping: true,
                  isColor: true,
                  videoPlayerController: VideoPlayerController.network(
                      widget.apartment != null
                          ? widget.apartment.videos[0]
                          : widget.house.videos[0])),
            ),
            expandedHeight: 250,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            //imgs
            Container(
              margin: EdgeInsets.only(top: 20, left: 14, right: 10),
              //height: 300,
              child: _buildImages(
                  apartment: widget.apartment,
                  house: widget.house,
                  context: context),
            ),
            //title
            _buildTitle(
                apartment: widget.apartment,
                house: widget.house,
                bloc: exploreBloc),
            _buildHostDetails(
                apartment: widget.apartment,
                house: widget.house,
                context: context,
                bloc: exploreBloc),
            _buildRoom(
              apartment: widget.apartment,
              house: widget.house,
            ),
            Container(
              margin: EdgeInsets.only(left: 18, top: 20),
              child: Text(widget.apartment != null
                  ? widget.apartment.description
                  : widget.house.description),
            ),
            Container(
              margin: EdgeInsets.only(left: 18, top: 20),
              child: Text('Amenities'),
            ),
            _buildAmenity(
              apartment: widget.apartment,
              house: widget.house,
            ),
            _buildReview(
                apartment: widget.apartment,
                house: widget.house,
                bloc: exploreBloc),
          ])),
        ],
      ),
      bottomNavigationBar: _buildBottom(
          apartment: widget.apartment,
          house: widget.house,
          context: context,
          bloc: exploreBloc),
    );
  }
}

//title
Widget _buildTitle({
  Apartment apartment,
  House house,
  ExploreBloc bloc,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 18, top: 20),
        child:
            Text(apartment != null ? apartment.building['name'] : house.name),
      ),
      apartment != null
          ? Container(
              margin: EdgeInsets.only(left: 18, top: 2),
              child: Text('Apartment     ${apartment.number}'),
            )
          : Container(),
      Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 14),
              child: Icon(
                Icons.star,
                color: kPink,
              )),
          StreamBuilder<QuerySnapshot>(
              stream: apartment != null
                  ? bloc.getAptReviews(apartment.uid)
                  : bloc.getHouseReviews(house.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  return Text(calculateReview(snapshot.data.docs).toString());
                }
              }),
          Container(
            margin: EdgeInsets.only(
              left: 18,
            ),
            child: Text(apartment != null
                ? apartment.location['city']
                : house.location['city']),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 10,
            ),
            child: Text(apartment != null
                ? apartment.location['street']
                : house.location['street']),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(
          left: 18,
        ),
        child: Text(apartment != null
            ? '${apartment.price} Tsh/month'
            : '${house.price} Tsh/month'),
      ),
      Container(
        margin: EdgeInsets.only(
          left: 18,
        ),
        child: Text(apartment != null
            ? 'Terms ${apartment.terms} months'
            : 'Terms ${house.terms} months'),
      )
    ],
  );
}

//host
Widget _buildHostDetails(
    {Apartment apartment,
    House house,
    BuildContext context,
    ExploreBloc bloc}) {
  return StreamBuilder<UserModel>(
      stream: bloc.getUser(apartment != null ? apartment.hostId : house.hostId),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container();
        else {
          return Container(
            margin: EdgeInsets.only(left: 18, top: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(apartment != null ? 'Apartment' : 'House'),
                    Text('Hosted by ${snapshot.data.name}'),
                    Text('since ${snapshot.data.date.toString()}')
                  ],
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundImage: snapshot.data.dp != null
                      ? NetworkImage(snapshot.data.dp)
                      : null,
                  backgroundColor: snapshot.data.dp == null ? kGreen : null,
                )
              ],
            ),
          );
        }
      });
}

Widget _buildRoom({Apartment apartment, House house}) {
  return Container(
    margin: EdgeInsets.only(left: 18, top: 20, right: 20),
    child: Row(
      children: [
        Text(apartment != null
            ? '${apartment.bedrooms} bedrooms'
            : '${house.bedrooms} bedrooms'),
        Icon(Icons.king_bed_rounded),
        SizedBox(
          width: 10,
        ),
        Text(apartment != null
            ? '${apartment.bathrooms} bathrooms'
            : '${house.bathrooms} bathrooms'),
        Icon(Icons.bathtub),
      ],
    ),
  );
}

Widget _buildAmenity({Apartment apartment, House house}) {
  return Container(
    margin: EdgeInsets.only(left: 18, top: 20),
    child: Row(
      children: apartment != null
          ? apartment.amenities
              .map((amenity) => Expanded(
                  child: amenity != null
                      ? Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: kGreen),
                            ),
                            Expanded(child: Text(amenity)),
                          ],
                        )
                      : Container()))
              .toList()
          : house.amenities
              .map((amenity) => Expanded(
                  child: amenity != null
                      ? Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: kGreen),
                            ),
                            Expanded(child: Text(amenity)),
                          ],
                        )
                      : Container()))
              .toList(),
    ),
  );
}

Widget _buildReview({Apartment apartment, House house, ExploreBloc bloc}) {
  return StreamBuilder<QuerySnapshot>(
    stream: apartment != null
        ? bloc.getAptReviews(apartment.uid)
        : bloc.getHouseReviews(house.uid),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Container();
      } else {
        return Container(
          margin: EdgeInsets.only(left: 18, top: 20, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reviews'),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: kPink,
                  ),
                  Text(calculateReview(snapshot.data.docs).toString()),
                  Text('(${snapshot.data.docs.length})')
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    Review review =
                        Review.fromMap(snapshot.data.docs[index].data());
                    return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kBlack,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(18)),
                        child: Text(review.text));
                  }),
            ],
          ),
        );
      }
    },
  );
}

Widget _buildBottom(
    {Apartment apartment,
    House house,
    BuildContext context,
    ExploreBloc bloc}) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: MaterialButton(
          color: kGreen,
          onPressed: () {},
          child: Text(
            'Request to meet with host',
            style: TextStyle(color: kWhite),
          )));
}

Widget _buildImages({
  @required Apartment apartment,
  @required House house,
  @required BuildContext context,
}) {
  return GridView.count(
      childAspectRatio: 1.5,
      shrinkWrap: true,
      children: house != null
          ? _buildList(house.images)
          : _buildList(apartment.images),
      crossAxisCount: 2);
}

List<Widget> _buildList(List<dynamic> images) {
  return images
      .map((img) => Container(
            child: Card(
              child: Image.network(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ))
      .toList();
}
