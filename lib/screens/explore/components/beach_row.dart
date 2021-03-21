import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'build.dart';
import 'home_list.dart';

class BeachRow extends StatelessWidget {
  final Stream<List<QuerySnapshot>> stream;
  final String loadingText;

  final String emptyText;

  BeachRow({
    @required this.stream,
    @required this.loadingText,
    @required this.emptyText,
  });
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          StreamBuilder<List<QuerySnapshot>>(
            stream: stream,
            builder: (context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
              if (!snapshot.hasData) {
                return loader(loadingText);
              } else {
                final homeDocs = snapshot.data[0].docs + snapshot.data[1].docs;
                homeDocs.shuffle();
                return homeDocs.length > 0
                    ? Container(
                        //margin: EdgeInsets.only(left: 18),
                        height: 240,
                        child: HomeList(
                          homeDocs: homeDocs,
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(
                          left: 18,
                        ),
                        child: Text(emptyText));
              }
            },
          ),
        ],
      ),
    );
  }
}
