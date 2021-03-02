import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/user.dart';
import 'dart:io';
import 'package:napanga/screens/explore/components/person_info.dart';
import 'package:napanga/services/blocs/explore/explore_bloc.dart';
import 'package:napanga/widget/loading_indicator.dart';

class CustomDrawer extends StatefulWidget {
  final ExploreBloc exploreBloc;
  CustomDrawer({@required this.exploreBloc});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  UserModel user;
  File imageFile;

  Future upload(ExploreBloc bloc, String uid) async {
    var file = await bloc.chooseImage();
    setState(() {
      imageFile = file;
    });
    await bloc.uploadImage(imageFile: file, uid: uid);
  }

  @override
  void initState() {
    widget.exploreBloc.getCurrentUserStream.listen((event) {
      user = event;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          StreamBuilder<UserModel>(
              stream: widget.exploreBloc.getCurrentUserStream,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return DrawerHeader(
                    child: _buildHeader(
                      context: context,
                      user: snapshot.data,
                      bloc: widget.exploreBloc,
                      up: upload,
                      image: imageFile,
                    ),
                  );
                else
                  return buildLoading(context);
              }),
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
                  return PersonInfo(bloc: widget.exploreBloc);
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
                stream: widget.exploreBloc.getCurrentUserStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GestureDetector(
                        child: Text(snapshot.data.type == 'customer'
                            ? 'Switch to Host'
                            : 'Switch to Customer'),
                        onTap: snapshot.data.type == 'customer'
                            ? () {
                                widget.exploreBloc
                                    .updateType(snapshot.data.uid, 'host');
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/listing');
                              }
                            : () {
                                widget.exploreBloc
                                    .updateType(snapshot.data.uid, 'customer');
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/', (route) => false);
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
                widget.exploreBloc.logOut.then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'login', (route) => false));
              },
            ),
          ),
        ],
      ),
      elevation: 10,
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
      Row(
        children: [
          Text(user.name),
          SizedBox(
            width: 10,
          ),
          Text('joined in ${user.date.month}, ${user.date.year}')
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      Text(user.type)
    ],
  );
}
