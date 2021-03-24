
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:napanga/screens/explore/components/beach_row.dart';
import 'package:napanga/screens/explore/components/home_row.dart';
import 'package:napanga/services/blocs/explore/explore_bloc.dart';
import 'package:napanga/widget/custom_drawer.dart';
import 'package:napanga/widget/customer_bottom_nav.dart';
import 'components/build.dart';
import 'components/category.dart';


class Explore extends StatelessWidget {
  final int _index = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final ExploreBloc _exploreBloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('napanga'),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          //explore column
          buildColumn(context),
          //home category
          Category(bloc: _exploreBloc),
          //trending homes
          HomeRow(
            stream: _exploreBloc.topHomes,
            title: 'Top trending houses and apartments',
            loadingText: 'top trending homes..',
            emptyText: 'There are no trending homes for now',
          ),
          //city row
          HomeRow(
            stream: _exploreBloc.cityHomes,
            title: 'Live in the city in Beautiful homes',
            loadingText: 'city homes...',
            emptyText: 'There are no city homes for now',
          ),
          //beach homes
          SliverToBoxAdapter(
              child: buildRow(
                  context, 'Beautiful and amaizing homes near the beach')),
          BeachRow(
              stream: _exploreBloc.beachHomes,
              loadingText: 'beach homes..',
              emptyText: 'There are no beach homes for now'),
        ],
      ),
      bottomNavigationBar: CustomerBottomNav(
        newContext: context,
        currentIndex: _index,
      ),
      drawer: CustomDrawer(),
      //drawerScrimColor: kGreen,
    );
  }
}
