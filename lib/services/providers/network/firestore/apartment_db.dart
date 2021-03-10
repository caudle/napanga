import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:napanga/models/apartment.dart';

class ApartmentDatabase {
  //user collection
  static String _collectionName = 'apartments';
  final _collectionReference =
      FirebaseFirestore.instance.collection(_collectionName);

  //create collection
  Future<void> createApartment(Apartment apartment) {
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      await _collectionReference.doc().set({
        'hostId': apartment.hostId,
        'number': apartment.number,
        'description': apartment.description,
        'bedrooms': apartment.bedrooms,
        'bathrooms': apartment.bathrooms,
        'building': apartment.building,
        'price': apartment.price,
        'fee': apartment.fee,
        'terms': apartment.terms,
        'likes': apartment.likes,
        'category': apartment.category,
        'location': apartment.location,
        'review': apartment.review,
        'images': apartment.images,
        'videos': apartment.videos,
        'amenities': apartment.amenities,
        'date': Timestamp.fromDate(apartment.date),
      });
    });
  }

  //get all apartments
  Stream<QuerySnapshot> getAll() {
    return _collectionReference.snapshots();
  }

  //get top rated apartments
  Stream<QuerySnapshot> getTopRated() {
    return _collectionReference
        .where('review', isGreaterThanOrEqualTo: 4.0)
        .snapshots();
  }

  //retrieve city apartments
  Stream<QuerySnapshot> getCity() {
    return _collectionReference
        .where('category.city', isEqualTo: true)
        .snapshots();
  }

  //get apts for a user
  Stream<QuerySnapshot> getUserApts(String uid) {
    return _collectionReference.where('hostId', isEqualTo: uid).snapshots();
  }

  //calculate review
  Stream<QuerySnapshot> getReviews(String uid) {
    return _collectionReference.doc(uid).collection('reviews').snapshots();
  }

  //get apt
  Stream<DocumentSnapshot> getApt(String uid) {
    return _collectionReference.doc(uid).snapshots();
  }
}
