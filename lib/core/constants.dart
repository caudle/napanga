import 'package:flutter/material.dart';

//app colors
const kWhite = const Color(0xFFFFFFFF);
const kBlack = const Color(0xFF000000);
const kPink = const Color(0xFFFC5185);
const kGreen = const Color(0xFF1DB38C);

//red button theme
const ButtonThemeData kRedButtonData = ButtonThemeData(
    buttonColor: kGreen,
    shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10))));
