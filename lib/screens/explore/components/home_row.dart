import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/screens/explore/components/home_list.dart';

import 'build.dart';

class HomeRow extends StatelessWidget {
  final Stream<List<QuerySnapshot>> stream;
  final String loadingText;
  final String title;
  final String emptyText;
  HomeRow(
      {@required this.stream, this.title, this.loadingText, this.emptyText});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        buildRow(context, title),
        StreamBuilder<List<QuerySnapshot>>(
          stream: stream,
          builder: (context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
            if (!snapshot.hasData) {
              return loader(loadingText);
            } else {
              final homeDocs = snapshot.data[0].docs + snapshot.data[1].docs;
              homeDocs.shuffle();
              return homeDocs.length > 0
                  ? HomeList(
                      homeDocs: homeDocs,
                    )
                  : Container(
                      padding: EdgeInsets.only(
                        left: 18,
                      ),
                      child: Text(emptyText));
            }
          },
        ),
      ]),
    );
  }
}
