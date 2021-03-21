import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napanga/models/apartment.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/models/user.dart';
import 'package:napanga/screens/add/add.dart';
import 'package:napanga/screens/explore/components/build.dart';
import 'package:napanga/screens/listing/components/custom_card.dart';
import 'package:napanga/services/blocs/explore/explore_bloc.dart';
import 'package:napanga/services/blocs/listing/listing_bloc.dart';
import 'package:napanga/widget/custom_drawer.dart';
import 'package:napanga/widget/host_bottom_nav.dart';
import 'package:napanga/widget/loading_indicator.dart';

class Listing extends StatelessWidget {
  final index = 0;
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<ListingBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Listing'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 18,
              bottom: 10,
            ),
            child: Text('Apartments'),
          ),
          //list of apts
          buildApartments(bloc),
          Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 18,
              bottom: 10,
            ),
            child: Text('Houses'),
          ),
          buildHouses(bloc),
        ],
      ),
      floatingActionButton: buildFloating(context),
      bottomNavigationBar:
          HostBottomNav(currentIndex: index, newContext: context),
      drawer: CustomDrawer(),
    );
  }
}

//fab
Widget buildFloating(BuildContext context) {
  return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddListing();
        }));
      });
}

//houses
Widget buildHouses(bloc) {
  return StreamBuilder<UserModel>(
    stream: bloc.getCurrentUserStream,
    builder: (context, snapshot) {
      if (!snapshot.hasData)
        return buildLoading(context);
      else
        return StreamBuilder<QuerySnapshot>(
            stream: bloc.userHouses(snapshot.data.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return loader('Houses loading');
              else {
                return snapshot.data.docs.length > 0
                    ? GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: snapshot.data.docs.map((e) {
                          House house = House.fromMap(e.data());
                          house.uid = e.id;
                          return Container(
                            margin: EdgeInsets.only(left: 18),
                            child: CustomCard(apartment: null, house: house),
                          );
                        }).toList(),
                      )
                    : Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Text('Add Houses'),
                      );
              }
            });
    },
  );
}

//apts
Widget buildApartments(ListingBloc bloc) {
  return StreamBuilder<UserModel>(
    stream: bloc.getCurrentUserStream,
    builder: (context, snapshot) {
      if (!snapshot.hasData)
        return buildLoading(context);
      else
        return StreamBuilder<QuerySnapshot>(
            stream: bloc.userApts(snapshot.data.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return loader('Apartments loading');
              else {
                return snapshot.data.docs.length > 0
                    ? GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: snapshot.data.docs.map((e) {
                          Apartment apartment = Apartment.fromMap(e.data());
                          apartment.uid = e.id;
                          return Container(
                            margin: EdgeInsets.only(left: 18),
                            child:
                                CustomCard(apartment: apartment, house: null),
                          );
                        }).toList(),
                      )
                    : Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Text('Add apartments'),
                      );
              }
            });
    },
  );
}
