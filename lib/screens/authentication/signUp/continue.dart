import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';

import 'package:napanga/services/blocs/signup/signup_bloc.dart';

class Continue extends StatelessWidget {
  final SignupBloc signupBloc;

  Continue({
    @required this.signupBloc,
  });
  @override
  Widget build(BuildContext context) {
    return buildContinue(context: context, signupBloc: signupBloc);
  }
}

Widget buildContinue({
  @required BuildContext context,
  @required SignupBloc signupBloc,
}) {
  return Column(
    children: [
      //almost done
      Container(
        child: Text(
          'Almost done',
          style: Theme.of(context).textTheme.headline6,
        ),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 140, bottom: 40),
      ),
      //username field
      Padding(
        padding: const EdgeInsets.only(top: 20, right: 40, left: 40),
        child: StreamBuilder<String>(
            stream: signupBloc.username,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                signupBloc.usernameValue = snapshot.data;
              }
              return TextField(
                onChanged: signupBloc.usernameSink,
                decoration: InputDecoration(
                  errorText: snapshot.error,
                  labelText: 'username',
                  prefixIcon: Icon(
                    Icons.perm_identity,
                  ),
                ),
              );
            }),
      ),

      //pass1 field
      Padding(
        padding: const EdgeInsets.only(top: 8, right: 40, left: 40),
        child: StreamBuilder<String>(
            stream: signupBloc.password1,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                signupBloc.passwordValue = snapshot.data;
              }
              return TextField(
                onChanged: signupBloc.password1Sink,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: snapshot.error,
                  labelText: 'password',
                 
                  prefixIcon: Icon(
                    Icons.enhanced_encryption,
               
                  ),
                ),

              );
            }),
      ),

      //pass2 field

      Padding(
        padding: const EdgeInsets.only(top: 8, right: 40, left: 40),
        child: StreamBuilder<String>(
            stream: signupBloc.password2,
            builder: (context, snapshot) {
              return TextField(
                onChanged: signupBloc.password2Sink,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: snapshot.error,
                  labelText: 'confirm password',
               
                  prefixIcon: Icon(
                    Icons.enhanced_encryption,
                  ),
                ),
              );
            }),
      ),

      //sign up button
      _buildsignupButton(signupBloc: signupBloc),

      //back
      Padding(
        padding: EdgeInsets.only(
          left: 26,
        ),
        child: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: kGreen,
                ),
                onPressed: () {
                  signupBloc.add(BackEvent());
                }),
          ],
        ),
      ),

      //log in
      //_buildLogin(context: context, signupBloc: signupBloc),
    ],
  );
}

Widget _buildsignupButton({@required SignupBloc signupBloc}) {
  return Container(
    height: 83,
    width: 280,
    padding: const EdgeInsets.only(top: 20, bottom: 6),
  
      child: StreamBuilder<bool>(
          stream: signupBloc.signupStream,
          builder: (context, snapshot) {
            return RaisedButton(
                disabledColor: Colors.grey[300],
                elevation: 6.0,
                child: Text(
                  'sign up',
                  style: TextStyle(color: kWhite),
                ),
                onPressed: snapshot.hasData
                    ? () => signupBloc.add(SignupButtonEvent())
                    : null);
          }),
    
  );
}
