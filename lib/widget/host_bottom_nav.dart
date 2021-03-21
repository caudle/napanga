import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';

class HostBottomNav extends StatefulWidget {
  @override
  _HostBottomNavState createState() => _HostBottomNavState();

  final int currentIndex;
  final BuildContext newContext;
  HostBottomNav({@required this.currentIndex, @required this.newContext});
}

class _HostBottomNavState extends State<HostBottomNav> {
  List _routes = <String>['/listing', '/stats', '/profile'];

  //change index
  void _changeIndex(int index) {
    Navigator.pushNamedAndRemoveUntil(
        context, _routes[index], (route) => route.settings.name == '/listing');
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
          icon: Icon(Icons.apartment_outlined),
          label: 'Listing',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined),
          label: 'stats',
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
