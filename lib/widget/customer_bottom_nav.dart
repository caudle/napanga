import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';

class CustomerBottomNav extends StatefulWidget {
  final int currentIndex;
  final BuildContext newContext;
  CustomerBottomNav({@required this.currentIndex, @required this.newContext});
  @override
  _CustomerBottomNavState createState() => _CustomerBottomNavState();
}

class _CustomerBottomNavState extends State<CustomerBottomNav> {
  List _routes = <String>['/', '/saved', '/profile'];

  //change index
  void _changeIndex(int index) {
    Navigator.pushNamedAndRemoveUntil(
        context, _routes[index], (route) => route.settings.name == '/');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 12,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kGreen,
      unselectedItemColor: Colors.black,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.explore,
          ),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline_rounded),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.perm_identity),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.currentIndex,
      onTap: _changeIndex,
    );
  }
}
