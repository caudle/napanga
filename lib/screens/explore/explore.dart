
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napanga/core/theme.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          title:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height:10),
              Stack(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Material(
                      elevation: 2.0,
                        child: TextField(
                           inputFormatters: [
                             LengthLimitingTextInputFormatter(21)
                           ],
                        decoration: InputDecoration(
                          hintText: 'Category,Street,City...',
                           hintStyle: TextStyle(fontSize: 14.0, color: AppColor.blueMain),
                          prefixIcon: Icon(Icons.search,size:30),
                           contentPadding: EdgeInsets.all(0)
                        ),
                      ),
                    ),
                  ),
                    Positioned(
                    top: 0.0,
                    right: 10,
                    bottom: 0,
                    child: Container(
                      child: GestureDetector(
                      onTap: ()=> Navigator.pushNamed(context, '/filter'),
                      child: Row(
                        children:<Widget>[
                          Text('Filter',style:Theme.of(context).textTheme.headline4,),
                          Icon(Icons.filter_alt_outlined)
                        ]
                      ),
                      ),
                    ),),
                
                ],
              ),
            ],
          ),

        ),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          //explore column
          buildColumn(context),
          //home category
          //Category(bloc: _exploreBloc),
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
