import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:napanga/models/message.dart';
import 'package:napanga/screens/messages/components/chat_list.dart';
import 'package:napanga/services/repository.dart';

class Chat extends StatefulWidget {
  final String docId;
  final String receiverName;
  final String receiverDp;
  Chat(
      {@required this.docId,
      @required this.receiverName,
      @required this.receiverDp});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _repo = Repository();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverName),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _repo.getMessages(widget.docId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          } else {
            return ChatList(
              docs: snapshot.data.docs,
              userId: _repo.getUserId(),
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            IconButton(icon: Icon(Icons.send), onPressed: _onPressed)
          ],
        ),
      ),
    );
  }

  void _onPressed() {
    final repo = Repository();
    //create messsage
    Message message = Message(
        senderId: repo.getUserId(),
        receiverName: widget.receiverName,
        receiverDp: widget.receiverDp,
        date: DateTime.now(),
        text: messageController.value.text);
    //send to db
    repo.createMessage(widget.docId, message);
  }
}
