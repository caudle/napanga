import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/models/message.dart';

class ChatList extends StatelessWidget {
  final List<DocumentSnapshot> docs;
  final String userId;
  ChatList({@required this.docs, this.userId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: docs.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Message message = Message.fromMap(docs[index].data());
        return Container(
          alignment: userId == message.senderId
              ? Alignment.topRight
              : Alignment.topLeft,
          color: userId == message.senderId ? Colors.blue : Colors.grey,
          child: Text(message.text),
        );
      },
    );
  }
}
