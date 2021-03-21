class Message {
  String docId; //document id
  String senderId; //sender id
  String receiverName; //receiver name
  String receiverDp;
  String text;
  DateTime date;

  Message(
      {this.docId,
      this.senderId,
      this.receiverName,
      this.receiverDp,
      this.date,
      this.text});

  Message.fromMap(Map<String, dynamic> messageDocument)
      : senderId = messageDocument['senderId'],
        receiverName = messageDocument['receiverName'],
        receiverDp = messageDocument['receiverDp'],
        text = messageDocument['text'],
        date = messageDocument['date'].toDate();
}
