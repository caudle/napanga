import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:napanga/screens/authentication/core/form_widget.dart';

const padding = EdgeInsets.symmetric(horizontal: 8.0);
Widget buildSocialLoginRow(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top:25.0,right: 30, left: 30, bottom: 70),
    child: Row(
      children: <Widget>[
        __buildFacebookButtonWidget(context),
        __buildInstagramButtonWidget(context),
        __buildTwitterButtonWidget(context),
        __buildGoogleButtonWidget(context),
      ],
    ),
  );
}

Widget __buildTwitterButtonWidget(BuildContext context) {
  return Expanded(
    flex: 1,
    child: Padding(
      padding: padding,
      child: RaisedButton(
          color: Color.fromRGBO(29, 161, 242, 1.0),
          child: Icon(
            FontAwesomeIcons.twitter,
            color:Color(0xFFFFFFFF),
          ),
          onPressed: () {},
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(6.0))),
    ),
  );
}

Widget __buildFacebookButtonWidget(BuildContext context) {
  return Expanded(
    flex: 1,
    child: Padding(
      padding: padding,
      child: RaisedButton(
          color: Color.fromRGBO(42, 82, 151, 1.0),
          child: Icon(
            FontAwesomeIcons.facebookF,
             color:Color(0xFFFFFFFF),
          ),
          onPressed: () {},
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(6.0))),
    ),
  );
}

Widget __buildInstagramButtonWidget(BuildContext context) {
  return Expanded(
    flex: 1,
    child: Padding(
      padding: padding,
      child: RaisedGradientButton(
        child: Container(
          child: Icon(
            FontAwesomeIcons.instagram,
             color:Color(0xFFFFFFFF),
          ),
        ),
        onPressed: () {},
      ),
    ),
  );
}

Widget __buildGoogleButtonWidget(BuildContext context) {
  return Expanded(
    flex: 1,
    child: Padding(
      padding: padding,
      child: RaisedButton(
        color: const Color(0xFFbb001b),
        child: Icon(FontAwesomeIcons.google, 
        color:Color(0xFFFFFFFF),
        ),
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(6.0),
        ),
      ),
    ),
  );
}
