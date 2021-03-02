class Review {
  double rate;
  String text;
  String user;
  DateTime date;
  Review({this.rate, this.text, this.user, this.date});
  Review.fromMap(Map<String, dynamic> reviewDocument)
      : rate = reviewDocument['rate'],
        text = reviewDocument['text'],
        user = reviewDocument['user'],
        date = reviewDocument['date'].toDate();
}
