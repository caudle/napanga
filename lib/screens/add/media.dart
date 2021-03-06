import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/screens/add/location.dart';
import 'package:napanga/services/blocs/listing/listing_bloc.dart';
import 'package:napanga/widget/video_widget.dart';
import 'package:video_player/video_player.dart';

class ListingMedia extends StatefulWidget {
  @override
  _ListingMediaState createState() => _ListingMediaState();
  final Apartment apartment;
  final House house;
  ListingMedia({@required this.apartment, @required this.house});
}

class _ListingMediaState extends State<ListingMedia> {
  File imageBedOne;
  File imageBedTwo;
  File imageOutOne;
  File imageOutTwo;

  File video;
  double aspectRatio = 4;
  double videoHeight = 100;
  double videoWidth = 50;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<ListingBloc>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Media'),
              centerTitle: true,
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 18, bottom: 10),
              height: 20,
              child: Text('Bedroom Images'),
            ),
          ),
          //bedroom imgs
          SliverGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            children: [
              imageBedOne == null
                  ? Card(
                      margin: EdgeInsets.only(left: 18),
                      child: IconButton(
                          icon: Icon(Icons.add_photo_alternate),
                          onPressed: () async {
                            var file = await bloc.chooseImage();
                            setState(() {
                              imageBedOne = file;
                              aspectRatio = 1;
                            });
                          }),
                    )
                  : Card(
                      margin: EdgeInsets.only(left: 18),
                      child: GestureDetector(
                        child: Image.file(
                          imageBedOne,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              imageBedTwo == null
                  ? Card(
                      margin: EdgeInsets.only(right: 18),
                      child: IconButton(
                          icon: Icon(Icons.add_photo_alternate),
                          onPressed: () async {
                            var file = await bloc.chooseImage();
                            setState(() {
                              imageBedTwo = file;
                              aspectRatio = 1;
                            });
                          }),
                    )
                  : Card(
                      margin: EdgeInsets.only(right: 18),
                      child: GestureDetector(
                        child: Image.file(
                          imageBedTwo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
            ],
            childAspectRatio: aspectRatio,
          ),
          //externa img text
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 18, top: 20, bottom: 10),
              height: 20,
              child: Text('External sorrounding images'),
            ),
          ),
          //external imgs
          SliverGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            children: [
              imageOutOne == null
                  ? Card(
                      margin: EdgeInsets.only(left: 18),
                      child: IconButton(
                          icon: Icon(Icons.add_photo_alternate),
                          onPressed: () async {
                            var file = await bloc.chooseImage();
                            setState(() {
                              imageOutOne = file;
                              aspectRatio = 1;
                            });
                          }),
                    )
                  : Card(
                      margin: EdgeInsets.only(left: 18),
                      child: GestureDetector(
                        child: Image.file(
                          imageOutOne,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              imageOutTwo == null
                  ? Card(
                      margin: EdgeInsets.only(right: 18),
                      child: IconButton(
                          icon: Icon(Icons.add_photo_alternate),
                          onPressed: () async {
                            var file = await bloc.chooseImage();
                            setState(() {
                              imageOutTwo = file;
                              aspectRatio = 1;
                            });
                          }),
                    )
                  : Card(
                      margin: EdgeInsets.only(right: 18),
                      child: GestureDetector(
                        child: Image.file(
                          imageOutTwo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
            ],
            childAspectRatio: aspectRatio,
          ),
          //video txt
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 18, top: 20, bottom: 10),
              height: 20,
              child: Text('Video'),
            ),
          ),
          //video
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 18, top: 20, bottom: 10, right: 18),
              height: videoHeight,
              child: video == null
                  ? SizedBox(
                      width: 30,
                      child: Card(
                        child: IconButton(
                          icon: Icon(Icons.video_label),
                          onPressed: () async {
                            var file = await bloc.chooseVideo();
                            setState(() {
                              video = file;
                              videoWidth = 150;
                              videoHeight = 200;
                            });
                          },
                        ),
                        elevation: 12,
                      ),
                    )
                  : Card(
                      child: GestureDetector(
                        child: VideoWidget(
                            videoPlayerController:
                                VideoPlayerController.file(video)),
                      ),
                    ),
            ),
          ),
          //next button
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                  top: 30,
                  left: MediaQuery.of(context).size.width / 1.5,
                  right: 18,
                  bottom: 18),
              height: 45,
              child: RaisedButton(
                child: Text(
                  'Next',
                  style: TextStyle(color: kWhite),
                ),
                onPressed: () {
                  if (imageBedOne == null &&
                      imageOutOne == null &&
                      video == null) {
                    //error textx
                  } else {
                    //send apt details to nxt page
                    if (widget.apartment != null) {
                      widget.apartment.images = [
                        imageBedOne,
                        imageBedTwo,
                        imageOutOne,
                        imageOutTwo,
                      ];
                      widget.apartment.videos = [video];
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocProvider(
                          create: (context) => ListingBloc(),
                          child: LocationWidget(
                            apartment: widget.apartment,
                            house: null,
                          ),
                        );
                      }));
                    }
                    //send house details to nxt page
                    else {
                      widget.house.images = [
                        imageBedOne,
                        imageBedTwo,
                        imageOutOne,
                        imageOutTwo,
                      ];
                      widget.house.videos = [video];
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocProvider(
                          create: (context) => ListingBloc(),
                          child: LocationWidget(
                            apartment: null,
                            house: widget.house,
                          ),
                        );
                      }));
                    }
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
}
