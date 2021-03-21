import 'package:flutter/material.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Function onPressed;

  RaisedGradientButton({
    Key key,
    @required this.child,
    this.width = double.infinity,
    this.height = 35.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Gradient _gradient = LinearGradient(
        colors: [ColorUtils.themeGradientStart, ColorUtils.themeGradientEnd]);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(6.0)),
          gradient: _gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: new BorderRadius.all(Radius.circular(40.0)),
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}




class ColorUtils {
  static const Color primaryColor = Color(0xffEC9F05);
  static const Color MainColor = Color(0xff2ec4b6);
  static const Color accentColor = Color(0xffFF4E00);
  static const Color orangeGradientEnd = Color(0xfffc4a1a);
  static const Color orangeGradientStart = Color(0xfff7b733);
  static const Color themeGradientStart = Color(0xFF8E24AA);
  static const Color themeGradientEnd = Color(0xFFFB8C00);
  static const LinearGradient appBarGradient =
      LinearGradient(colors: [themeGradientStart, themeGradientEnd]);
}
