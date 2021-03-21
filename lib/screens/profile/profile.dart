import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/user.dart';
import 'package:napanga/screens/profile/components/person_info.dart';
import 'package:napanga/services/blocs/explore/explore_bloc.dart';
import 'package:napanga/widget/customer_bottom_nav.dart';
import 'package:napanga/widget/host_bottom_nav.dart';
import 'package:napanga/widget/loading_indicator.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final int index = 2;
  File imageFile;

  Future upload(ExploreBloc bloc, String uid) async {
    var file = await bloc.chooseImage();
    setState(() {
      imageFile = file;
    });
    await bloc.uploadImage(imageFile: file, uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final exploreBloc = BlocProvider.of<ExploreBloc>(context);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: Material(
              elevation: 2,
              child: StreamBuilder<UserModel>(
                  stream: exploreBloc.getCurrentUserStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return Container(
                        margin: EdgeInsets.only(top: 8, bottom: 18),
                        child: _buildHeader(
                          context: context,
                          user: snapshot.data,
                          bloc: exploreBloc,
                          up: upload,
                          image: imageFile,
                        ),
                      );
                    else
                      return buildLoading(context);
                  }),
            ),
          ),
          //acc settings
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 10),
            child: Text('ACCOUNT SETTINGS'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: GestureDetector(
              child: Text('Personal Information'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PersonInfo(bloc: exploreBloc);
                }));
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          //acc settings
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 10),
            child: Text('ACCOUNT SWITCH'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: StreamBuilder<UserModel>(
                stream: exploreBloc.getCurrentUserStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GestureDetector(
                        child: Text(snapshot.data.type == 'customer'
                            ? 'Switch to Host'
                            : 'Switch to Customer'),
                        onTap: snapshot.data.type == 'customer'
                            ? () {
                                exploreBloc.updateType(
                                    snapshot.data.uid, 'host');
                                Navigator.pushReplacementNamed(
                                    context, '/listing');
                              }
                            : () {
                                exploreBloc.updateType(
                                    snapshot.data.uid, 'customer');
                                Navigator.pushReplacementNamed(context, '/');
                              });
                  } else
                    return buildLoading(context);
                }),
          ),
          SizedBox(
            height: 25,
          ),
          //legal
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 10),
            child: Text('LEGAL'),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
            ),
            child: GestureDetector(
              child: Text('Terms of service'),
              onTap: () {},
            ),
          ),
          SizedBox(
            height: 25,
          ),
          //log out
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 10),
            child: GestureDetector(
              child: Text('Log out'),
              onTap: () {
                exploreBloc.logOut.then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'login', (route) => false));
              },
            ),
          ),
        ],
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

Widget _buildHeader({
  @required BuildContext context,
  @required UserModel user,
  @required ExploreBloc bloc,
  @required Future Function(ExploreBloc, String) up,
  @required File image,
}) {
  return Column(
    children: [
      GestureDetector(
        child: user.dp != null
            ? CircleAvatar(
                backgroundImage:
                    image != null ? FileImage(image) : NetworkImage(user.dp),
                radius: 50,
              )
            : CircleAvatar(
                backgroundImage: image != null ? FileImage(image) : null,
                backgroundColor: image != null ? null : kGreen,
                radius: 50,
              ),
        onTap: () async {
          await up(bloc, user.uid);
        },
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            Text(user.name),
            SizedBox(
              width: 10,
            ),
            Text('joined in ${user.date.month}, ${user.date.year}')
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      Text(user.type)
    ],
  );
}
