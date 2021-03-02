import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';

Widget buildColumn(BuildContext context) => SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 20, bottom: 5),
            child:
                Text('Explore', style: Theme.of(context).textTheme.headline6),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 12),
            child: Text(
              'Let\'s help you find your dream home',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );

Widget buildRow(BuildContext context, String text) {
  return Container(
    padding: EdgeInsets.only(
      left: 18,
      top: 18,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Text(text, style: Theme.of(context).textTheme.subtitle2),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: kPink,
                size: 14,
              ),
              onPressed: null),
        ),
      ],
    ),
  );
}

Widget loader(String text) => Column(
      children: [
        CircularProgressIndicator(),
        Text(text),
      ],
    );
