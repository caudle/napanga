import 'package:flutter/material.dart';
import 'package:napanga/models/user.dart';
import 'package:napanga/services/blocs/explore/explore_bloc.dart';

class PersonInfo extends StatefulWidget {
  final ExploreBloc bloc;
  PersonInfo({@required this.bloc});
  @override
  _PersonInfoState createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

   

  @override
  void initState() {
    widget.bloc.getCurrentUserStream.listen((user) {
      _nameController.text = user.name;
      _phoneController.text = user.phone;
      _emailController.text = user.email;
      _usernameController.text = user.username;
    });
     
    super.initState();
 
  }


  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Personal Information'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //name
            Padding(
              padding: const EdgeInsets.only(top: 28.0, left: 18, bottom: 1),
              child: Text('name'),
            ),
            StreamBuilder<UserModel>(
                stream: widget.bloc.getCurrentUserStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.only(left: 18),
                      width: 200,
                      child: TextField(
                        controller: _nameController,
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                }),
            //phone
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 18, bottom: 1),
              child: Text('Phone'),
            ),
            StreamBuilder<UserModel>(
                stream: widget.bloc.getCurrentUserStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.only(left: 18),
                      width: 200,
                      child: TextField(
                        controller: _phoneController,
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                }),
            //email
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 18, bottom: 1),
              child: Text('Email'),
            ),
            StreamBuilder<UserModel>(
                stream: widget.bloc.getCurrentUserStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.only(left: 18),
                      width: 200,
                      child: TextField(
                        controller: _emailController,
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                }),
            //username
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 18, bottom: 1),
              child: Text('username'),
            ),
            StreamBuilder<UserModel>(
                stream: widget.bloc.getCurrentUserStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.only(left: 18),
                      width: 200,
                      child: TextField(
                        controller: _usernameController,
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                }),
          ],
        ));
  }
}
