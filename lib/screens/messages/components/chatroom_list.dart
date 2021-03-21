import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';
import 'package:napanga/models/message.dart';
import 'package:napanga/screens/messages/components/chat.dart';
import 'package:napanga/services/repository.dart';

class ChatRoomList extends StatelessWidget {
  final List<DocumentSnapshot> docs;
  ChatRoomList({@required this.docs});
  final _repo = Repository();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: docs.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return FutureBuilder<QuerySnapshot>(
            future: _repo.getMessages(docs[index].id).first,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              } else {
                Message message = Message.fromMap(snapshot.data.docs[0].data());
                return GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return Chat(
                      docId: docs[index].id,
                      receiverName: message.receiverName,
                      receiverDp: message.receiverDp,
                    );
                  })),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: message.receiverDp != null
                          ? NetworkImage(message.receiverDp)
                          : null,
                      backgroundColor:
                          message.receiverDp == null ? kGreen : null,
                      radius: 20,
                    ),
                    title: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(message.receiverName)),
                    subtitle: Container(
                        padding: EdgeInsets.all(8), child: Text(message.text)),
                    trailing: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(message.date.minute.toString())),
                  ),
                );
              }
            });
      },
    );
  }
}
