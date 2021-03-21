import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //header
          DrawerHeader(
              decoration: BoxDecoration(color: kGreen),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'napanga',
                  style: TextStyle(color: kWhite, fontSize: 20),
                ),
              )),

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/messages'),
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 10, top: 40),
              child: Text(
                'Messages',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 10, top: 20),
              child: Text(
                'Notifications',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      elevation: 10,
    );
  }
}
