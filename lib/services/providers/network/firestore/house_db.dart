import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:napanga/models/house.dart';

class HouseDatabase {
  //house collection
  static String _collectionName = 'houses';
  final _collectionReference =
      FirebaseFirestore.instance.collection(_collectionName);

  //create collection
  Future<void> createHouse(House house) {
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      await _collectionReference.doc().set({
        'hostId': house.hostId,
        'name': house.name,
        'description': house.description,
        'bedrooms': house.bedrooms,
        'bathrooms': house.bathrooms,
        'price': house.price,
        'fee': house.fee,
        'terms': house.terms,
        'likes': house.likes,
        'category': house.category,
        'location': house.location,
        'review': house.review ?? 0,
        'images': house.images,
        'videos': house.videos,
        'amenities': house.amenities,
        'date': Timestamp.fromDate(house.date),
      });
    });
  }

  //get all houses
  Stream<QuerySnapshot> getAll() {
    return _collectionReference.snapshots();
  }

  //get top rated houses
  Stream<QuerySnapshot> getTopRated() {
    return _collectionReference
        .where('review', isGreaterThanOrEqualTo: 3.5)
        .snapshots();
  }

  //retrieve city houses
  Stream<QuerySnapshot> getCity() {
    return _collectionReference
        .where('category.city', isEqualTo: true)
        .snapshots();
  }

  //get beach houses
  Stream<QuerySnapshot> getBeach() {
    return _collectionReference
        .where('category.beach', isEqualTo: true)
        .snapshots();
  }

  //get houses for a user
  Stream<QuerySnapshot> getUserHouses(String uid) {
    return _collectionReference.where('hostId', isEqualTo: uid).snapshots();
  }

  //calculate review
  Stream<QuerySnapshot> getReviews(String uid) {
    return _collectionReference.doc(uid).collection('reviews').snapshots();
  }

  //get house
  Stream<DocumentSnapshot> getHouse(String uid) {
    return _collectionReference.doc(uid).snapshots();
  }
}
