import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/screens/stats/components/stats_list.dart';
import 'package:napanga/services/repository.dart';
import 'package:napanga/widget/host_bottom_nav.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final repo = Repository();
  final index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats'),
      ),
      body: StreamBuilder<List<QuerySnapshot>>(
        stream: repo.getUserHomes(userId: repo.getUserId()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          } else {
            final homeDocs = snapshot.data[0].docs + snapshot.data[1].docs;
            return homeDocs.length > 0
                ? StatsList(homeDocs: homeDocs)
                : Container(
                    alignment: Alignment.topCenter,
                    child: Text('Your homes will appear here'),
                  );
          }
        },
      ),
      bottomNavigationBar:
          HostBottomNav(currentIndex: index, newContext: context),
    );
  }
}
