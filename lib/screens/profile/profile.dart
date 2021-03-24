import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napanga/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:napanga/models/user.dart';
import 'package:napanga/services/blocs/explore/explore_bloc.dart';
import 'package:napanga/widget/customer_bottom_nav.dart';
import 'package:napanga/widget/host_bottom_nav.dart';
import 'package:napanga/widget/loading_indicator.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  @override

    final int index = 2;
  File imageFile;

  Future upload(ExploreBloc bloc, String uid) async {
    var file = await bloc.chooseImage();
    setState(() {
      imageFile = file;
    });
    await bloc.uploadImage(imageFile: file, uid: uid);
  }
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
        // ignore: close_sinks
    final exploreBloc = BlocProvider.of<ExploreBloc>(context);
             return Scaffold(
                 body: Container(
                   color: AppColor.constColorWht,
                   child: ListView(
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(5.0),
                         child: Container(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.75))
                    ],
                    color: AppColor.dPrimaryTextColor,
                  ),
                  child: Row(
                    children: <Widget>[
                      StreamBuilder<UserModel>(
                  stream: exploreBloc.getCurrentUserStream,
                  builder: (context,snapshot){
                    if (snapshot.hasData)
                      return Container(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/masenu.jpg'),
                        ),
                        height: 80,
                        width: 80,
                        margin: EdgeInsets.only(left: 30, top: 30, right: 7),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.blueMain,
                        ),
                      );
                      }
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                left: 10,
                              ),
                              child: Text(
                                'Masenu Msuya',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                //ExtendedNavigator.of(context).pushShowProfile();
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                padding: EdgeInsets.all(0),
                                child: Text(
                                  'View',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.blueMain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
         
                      buildTextHeader('Account Settings'),
                      Container(
                        padding: EdgeInsets.only(top: 3, bottom: 10, left: 10),
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColor.dPrimaryTextColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            buildContainerMenu(
                              'Personal Information',
                              FontAwesomeIcons.userCircle,
                              0.9,
                              width,
                              FontWeight.w400,
                              18,
                            ),
                            buildContainerMenu(
                              'General',
                              FontAwesomeIcons.slidersH,
                              0.9,
                              width,
                              FontWeight.w400,
                              18,
                            ),
                            /*buildContainerMenu(
                              'Subscription',
                              FontAwesomeIcons.moneyBill,
                              0.0,
                              width,
                              FontWeight.w400,
                              18,
                            ),*/
                              buildContainerMenu(
                              'Notifications',
                              FontAwesomeIcons.bell,
                              0.0,
                              width,
                              FontWeight.w400,
                              18,
                            ),
                          ],
                        ),
                      ),
                      buildTextHeader('Support'),
                      Container(
                        padding: EdgeInsets.only(top: 3, bottom: 10, left: 10),
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColor.dPrimaryTextColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            buildContainerMenu(
                                'ContactUs',
                                FontAwesomeIcons.phone,
                                0.9,
                                width,
                                FontWeight.w400,
                                18),
                            buildContainerMenu(
                              'Get help',
                              FontAwesomeIcons.questionCircle,
                              0.9,
                              width,
                              FontWeight.w400,
                              18,
                            ),
                            buildContainerMenu(
                                'Resource Center',
                                FontAwesomeIcons.book,
                                0.9,
                                width,
                                FontWeight.w400,
                                18),
                            buildContainerMenu(
                                'Community Center',
                                FontAwesomeIcons.bullhorn,
                                0.9,
                                width,
                                FontWeight.w400,
                                18),
                            buildContainerMenu(
                              'Our Website',
                              FontAwesomeIcons.internetExplorer,
                              0.0,
                              width,
                              FontWeight.w400,
                              18,
                            ),
                          ],
                        ),
                      ),
                      buildTextHeader('Share'),
                      Container(
                        padding: EdgeInsets.only(top: 3, bottom: 10, left: 10),
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColor.dPrimaryTextColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            buildContainerMenu(
                              'Tell a Friend',
                              FontAwesomeIcons.share,
                              0.9,
                              width,
                              FontWeight.w400,
                              18,
                            ),
                            buildContainerMenu(
                              'Rate us',
                              FontAwesomeIcons.star,
                              0.0,
                              width,
                              FontWeight.w400,
                              18,
                            ),
                          ],
                        ),
                      ),
                      buildTextHeader('Legal'),
                      Container(
                        padding: EdgeInsets.only(top: 3, bottom: 10, left: 10),
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColor.dPrimaryTextColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            buildContainerMenu(
                              'Terms of Services',
                              FontAwesomeIcons.handshake,
                              0.9,
                              width,
                              FontWeight.w400,
                              18,
                            ),
                            buildContainerMenu(
                              'Privacy Policies',
                              FontAwesomeIcons.userShield,
                              0,
                              width,
                              FontWeight.w400,
                              18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.only(top: 7, bottom: 7, left: 10),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColor.dPrimaryTextColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: buildContainerMenu(
                        'Logout',
                        FontAwesomeIcons.signOutAlt,
                        0.0,
                        width,
                        FontWeight.bold,
                        18),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Version'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: StreamBuilder<UserModel>(
        stream: exploreBloc.getCurrentUserStream,
        builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.type == 'customer'
                  ? CustomerBottomNav(currentIndex: index, newContext: context)
                  : HostBottomNav(currentIndex: index, newContext: context);
            } else
              return Container();
          }),
      );
      
     
  }
}

  Widget buildTextHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 13),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.playfairDisplay(
          textStyle: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }

  Container buildContainerMenu(String name, IconData fa, double num,
      double width, FontWeight fontW, double fontSize) {
    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4),
      padding: EdgeInsets.only(top: 4, bottom: 10),
      decoration: num > 0
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(width: num, color: AppColor.constColorWht),
              ),
            
            )
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0, color: AppColor.dPrimaryTextColor),
              ),
              color: AppColor.dPrimaryTextColor,
            ),
      child: Row(
        children: [
          Container(
            child: Text(
              name,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontWeight: fontW,
                    fontSize: fontSize,
                   ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Container(
              child: FaIcon(
                fa,
                size: 23,
                color: AppColor.blueMain,
              ),
            ),
          ),
        ],
      ),
    );
  }


