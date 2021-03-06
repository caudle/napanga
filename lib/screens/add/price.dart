import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/services/blocs/listing/listing_bloc.dart';

class PriceWidget extends StatefulWidget {
  @override
  _PriceWidgetState createState() => _PriceWidgetState();
  final Apartment apartment;
  final House house;
  PriceWidget({@required this.apartment, @required this.house});
}

class _PriceWidgetState extends State<PriceWidget> {
  TextEditingController rentController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController termsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool load = false;
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<ListingBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Price'),
      ),
      body: load
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                        'Almost done, Now lets finish up setting your place'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 18, top: 20, bottom: 10),
                    child: Text('Rent per month in Tsh'),
                  ),
                  //rent
                  Container(
                      margin: EdgeInsets.only(left: 18, right: 50),
                      child: TextFormField(
                        controller: rentController,
                        decoration: InputDecoration(hintText: 'eg: 200,000'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'enter rent';
                          }
                          return null;
                        },
                      )),
                  //number of terms
                  Container(
                    margin: EdgeInsets.only(left: 18, top: 20, bottom: 10),
                    child: Text('Number of terms in months'),
                  ),

                  Container(
                      margin: EdgeInsets.only(left: 18, right: 50),
                      child: TextFormField(
                        controller: termsController,
                        decoration: InputDecoration(hintText: 'eg: 6'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'enter terms';
                          }
                          return null;
                        },
                      )),
                  //dalali fee
                  Container(
                    margin: EdgeInsets.only(left: 18, top: 30, bottom: 10),
                    child: Text('Dalali fee'),
                  ),
                  //rent
                  Container(
                      margin: EdgeInsets.only(left: 18, right: 50),
                      child: TextFormField(
                        controller: feeController,
                        decoration: InputDecoration(hintText: 'eg: 10,000'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'enter fee';
                          }
                          return null;
                        },
                      )),

                  //next
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 70, right: 10),
                      width: 100,
                      child: RaisedButton(
                        child: Text(
                          'Next',
                          style: TextStyle(color: kWhite),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              load = true;
                            });
                            List imgs = [];

                            List vids = [];
                            //aprtment
                            if (widget.apartment != null) {
                              //send imgs and vds to fbs storg
                              if (widget.apartment.images[0] != null) {
                                var res = await bloc.uploadHomeImage(
                                    widget.apartment.images[0],
                                    home: 'apartment');
                                imgs.add(res);
                              }
                              if (widget.apartment.images[1] != null) {
                                var res = await bloc.uploadHomeImage(
                                    widget.apartment.images[1],
                                    home: 'apartment');
                                imgs.add(res);
                              }
                              if (widget.apartment.images[2] != null) {
                                var res = await bloc.uploadHomeImage(
                                    widget.apartment.images[2],
                                    home: 'apartment');
                                imgs.add(res);
                              }
                              if (widget.apartment.images[3] != null) {
                                var res = await bloc.uploadHomeImage(
                                    widget.apartment.images[3],
                                    home: 'apartment');
                                imgs.add(res);
                              }
                              if (widget.apartment.videos[0] != null) {
                                var res = await bloc.uploadVideo(
                                    widget.apartment.videos[0],
                                    home: 'apartment');
                                vids.add(res);
                              }

                              widget.apartment.images = imgs;
                              widget.apartment.videos = vids;
                              widget.apartment.price =
                                  double.parse(rentController.value.text);
                              widget.apartment.terms =
                                  int.parse(termsController.value.text);
                              widget.apartment.date = DateTime.now();
                              widget.apartment.hostId = await bloc
                                  .getCurrentUser
                                  .then((value) => value.uid);

                              //send apt to firestor dtbs
                              await bloc.createApartment(widget.apartment);
                              //go to listing page
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/listing',
                                  (route) => route.settings.name == '/');
                            }
                            //house
                            else {
                              //send imgs and vds to fbs storg
                              if (widget.house.images[0] != null) {
                                var res = await bloc.uploadHomeImage(
                                    widget.house.images[0],
                                    home: 'house');
                                imgs.add(res);
                              }
                              if (widget.house.images[1] != null) {
                                var res = await bloc.uploadHomeImage(
                                    widget.house.images[1],
                                    home: 'house');
                                imgs.add(res);
                              }
                              if (widget.house.images[2] != null) {
                                var res = await bloc.uploadHomeImage(
                                    widget.house.images[2],
                                    home: 'house');
                                imgs.add(res);
                              }
                              if (widget.house.images[3] != null) {
                                var res = await bloc.uploadHomeImage(
                                    widget.house.images[3],
                                    home: 'house');
                                imgs.add(res);
                              }
                              if (widget.house.videos[0] != null) {
                                var res = await bloc.uploadVideo(
                                    widget.house.videos[0],
                                    home: 'house');
                                vids.add(res);
                              }
                              //update imgs and vids value
                              widget.house.images = imgs;
                              widget.house.videos = vids;
                              widget.house.price =
                                  double.parse(rentController.value.text);
                              widget.house.terms =
                                  int.parse(termsController.value.text);
                              widget.house.date = DateTime.now();
                              widget.house.hostId = await bloc.getCurrentUser
                                  .then((value) => value.uid);

                              //send apt to firestor dtbs
                              await bloc.createHouse(widget.house);
                              //go to listing page
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/listing',
                                  (route) => route.settings.name == '/');
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
            ),
    );
  }
}
