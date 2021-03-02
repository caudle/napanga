import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData _themeData = ThemeData.light();

ThemeData buildTheme() {
  return _themeData.copyWith(
      primaryColor: kWhite,
      accentColor: kPink,
      textTheme: _textTheme,
      buttonColor: kPink,
      scaffoldBackgroundColor: kWhite,
      iconTheme: IconThemeData(color: kBlack, size: 24.0),
      appBarTheme: _appBarTheme);
}

TextTheme _textTheme = _themeData.textTheme.copyWith(
  headline5: TextStyle(color: kGreen),
);

AppBarTheme _appBarTheme = AppBarTheme(
  color: kGreen,
);
