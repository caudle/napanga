import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:napanga/models/review.dart';

double calculateReview(List<DocumentSnapshot> docs) {
  double totalRate = 0;
  docs.forEach((doc) {
    Review review = Review.fromMap(doc.data());
    totalRate = totalRate + review.rate;
  });
  return docs.length > 0 ? totalRate / docs.length : 0;
}
