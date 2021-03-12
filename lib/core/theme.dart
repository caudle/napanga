import 'package:flutter/material.dart';

class AppColor{
  //dark theme
 static const dBackgroundColor = const Color(0xFF15202B);
 static const dCardColor = const Color(0xFF192734);
 static const dHoverColor = const Color(0xFF22303C);
 static const dPrimaryTextColor = const Color(0xFFFFFFFF);
static const dSecondaryTextColor = const Color(0xFF8899a6);
 static const kPink = const Color(0xFFFC5185);
 static const btonColor = const Color(0xFF1DB38C);
//light theme
 static const lightPrimaryTextColor = const Color(0xFF222222);
 static const lightSecondaryTextColor =const Color(0xFF15202B);
 

}

ThemeData _themeData = ThemeData.light();

ThemeData lightTheme(BuildContext context){

  final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColor.dPrimaryTextColor,
     textTheme: ThemeData.light().textTheme.copyWith(
      bodyText1: TextStyle(color:AppColor.lightSecondaryTextColor,),
      bodyText2: TextStyle(color:AppColor.lightSecondaryTextColor,),
      headline1: TextStyle(color:AppColor.lightPrimaryTextColor,),
      headline2: TextStyle(color:AppColor.lightPrimaryTextColor,),
      headline3: TextStyle(color:AppColor.lightPrimaryTextColor,),
      headline4: TextStyle(color:AppColor.lightPrimaryTextColor,),
      headline5: TextStyle(color:AppColor.lightPrimaryTextColor,),
      headline6: TextStyle(color:AppColor.lightPrimaryTextColor,),
      
    ),

    iconTheme: IconThemeData(color:AppColor.lightSecondaryTextColor,size: 20.0),
    hintColor: AppColor.lightSecondaryTextColor,
    disabledColor: AppColor.lightPrimaryTextColor,
    highlightColor:AppColor.btonColor ,
    hoverColor: AppColor.btonColor,
    focusColor: AppColor.btonColor,
    primaryIconTheme:IconThemeData(color:AppColor.dBackgroundColor),
    inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColor.dSecondaryTextColor,
    filled: true,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,  
    ),
    
    appBarTheme: AppBarTheme(
      
    ),
  );

  return lightTheme;

}

ThemeData darkTheme(BuildContext context){
  final ThemeData darkTheme =ThemeData.dark().copyWith(
    primaryColor: AppColor.dCardColor,
    highlightColor: AppColor.dHoverColor,
    scaffoldBackgroundColor: AppColor.dBackgroundColor,
    textTheme: ThemeData.dark().textTheme.copyWith(
      bodyText1: TextStyle(color:AppColor.dSecondaryTextColor,),
      bodyText2: TextStyle(color:AppColor.dSecondaryTextColor,),
      headline1: TextStyle(color:AppColor.dPrimaryTextColor,),
      headline2: TextStyle(color:AppColor.dPrimaryTextColor,),
      headline3: TextStyle(color:AppColor.dPrimaryTextColor,),
      headline4: TextStyle(color:AppColor.dPrimaryTextColor,),
      headline5: TextStyle(color:AppColor.dPrimaryTextColor,),
      headline6: TextStyle(color:AppColor.dPrimaryTextColor,),
    ),
    iconTheme: IconThemeData(color:AppColor.dPrimaryTextColor,size: 20.0),
    focusColor: AppColor.dCardColor,
    hoverColor: AppColor.dHoverColor,
    hintColor: AppColor.dSecondaryTextColor,
    disabledColor: AppColor.dPrimaryTextColor,


    
    cardColor: AppColor.dCardColor,
    accentColor: AppColor.dPrimaryTextColor,
  );
return darkTheme;
}



