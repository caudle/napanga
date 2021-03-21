import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/services/blocs/explore/explore_bloc.dart';

class Category extends StatelessWidget {
  final ExploreBloc bloc;
  Category({@required this.bloc});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(left: 0, right: 0),
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: bloc.getApts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(child: CircularProgressIndicator());
                } else {
                  List images = snapshot.data.docs.first.data()['images'];
                  List docs = snapshot.data.docs;
                  return Container(
                    margin: EdgeInsets.only(left: 15),
                    width: 250,
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 150,
                            child: Image.network(
                              images[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 8),
                              child: Text('Over ${docs.length} apartments'))
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            StreamBuilder<QuerySnapshot>(
                stream: bloc.getHouses(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    List images = snapshot.data.docs.first.data()['images'];
                    List docs = snapshot.data.docs;
                    return Container(
                      margin: EdgeInsets.only(right: 6),
                      width: 250,
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                                width: 250,
                                height: 150,
                                child: Image.network(images[0],
                                    fit: BoxFit.cover)),
                            Container(
                                padding: EdgeInsets.only(top: 8),
                                child: Text('Over ${docs.length} houses'))
                          ],
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
