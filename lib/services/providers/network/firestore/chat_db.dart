import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:napanga/models/message.dart';

class ChatDatabase {
  //chatroom collection
  static String _collectionName = 'chatrooms';
  final _collectionReference =
      FirebaseFirestore.instance.collection(_collectionName);

  //create chatroom collection
  Future createChatRoom(String senderId, String receiverId) async {
    try {
      String docId = senderId + receiverId;
      DocumentReference reference = _collectionReference.doc(docId);
      Map<String, dynamic> data = {
        'docId': docId,
        'ids': [senderId, receiverId],
        'date': Timestamp.now()
      };
      return await FirebaseFirestore.instance
          .runTransaction((transaction) => reference.set(data));
    } catch (e) {
      print(e);
      return e;
    }
  }

  //get doc
  Future<DocumentSnapshot> getChatRoomDoc(String docId) async {
    try {
      return await _collectionReference.doc(docId).get();
    } catch (e) {
      return e;
    }
  }

  //get chatroom docs
  Stream<QuerySnapshot> getChatRooms(String userId) {
    try {
      return _collectionReference
          .where('ids', arrayContains: userId)
          .snapshots();
    } catch (e) {
      return e;
    }
  }

  //create message collection
  Future createMessage(String docId, Message message) async {
    try {
      //find doc
      DocumentReference reference =
          _collectionReference.doc(docId).collection('messages').doc();
      //create data
      Map<String, dynamic> data = {
        'senderId': message.senderId,
        'receiverName': message.receiverName,
        'receiverDp': message.receiverDp,
        'text': message.text,
        'date': Timestamp.fromDate(message.date),
      };
      //store to db
      return await FirebaseFirestore.instance
          .runTransaction((transaction) => reference.set(data));
    } catch (e) {
      print(e);
      return e;
    }
  }

  //get message
  Stream<QuerySnapshot> getMessages(String docId) {
    try {
      return _collectionReference.doc(docId).collection('messages').snapshots();
    } catch (e) {
      print(e);

      return e;
    }
  }
}
