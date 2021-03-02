import 'package:flutter/material.dart';

Widget buildLoading(BuildContext context) {
  return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
      child: Center(child: CircularProgressIndicator()));
}
