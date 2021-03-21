import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/screens/messages/components/chatroom_list.dart';
import 'package:napanga/services/repository.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repo = Repository();
    return Scaffold(
      appBar: AppBar(
        title: Text('messages'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: repo.getChatRooms(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          } else {
            final docs = snapshot.data.docs;
            return docs.length > 0
                ? ChatRoomList(docs: docs)
                : Container(
                    alignment: Alignment.center,
                    child: Text('No messages'),
                  );
          }
        },
      ),
    );
  }
}
