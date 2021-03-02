import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:napanga/models/user.dart';
import 'package:napanga/services/auth.dart';

class UserDatabase {
  //user collection
  static String _collectionName = 'users';
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(_collectionName);
  final AuthService _authService = AuthService();
  // create user
  Future<void> createUser(UserModel userModel) {
    DocumentReference reference = userCollection.doc(userModel.uid);
    Map<String, dynamic> userData = {
      'uid': userModel.uid,
      'name': userModel.name,
      'phone': userModel.phone,
      'email': userModel.email,
      'username': userModel.username,
      'password': userModel.password,
      'date': Timestamp.fromDate(userModel.date),
      'type': userModel.type != null ? userModel.type : 'customer',
    };
    return FirebaseFirestore.instance
        .runTransaction((transaction) async => await reference.set(userData));
  }

  //get current user
  Future<UserModel> getCurrentUser() async {
    //get current user from firebase
    UserModel userModel = _authService.getCurrentUser();
    DocumentSnapshot documentSnapshot =
        await userCollection.doc(userModel.uid).get();
    //get user from firestore and return user
    UserModel user = documentSnapshot != null
        ? UserModel.fromMap(documentSnapshot.data())
        : null;
    return user;
  }

  //current user stream
  Stream<UserModel> getCurrentUserStream() {
    UserModel userModel = _authService.getCurrentUser();
    return userCollection
        .doc(userModel.uid)
        ?.snapshots()
        ?.map((doc) => UserModel.fromMap(doc.data()));
  }

  //get user
  Future<UserModel> getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await userCollection.doc(uid).get();
    UserModel user = documentSnapshot != null
        ? UserModel.fromMap(documentSnapshot.data())
        : null;
    return user;
  }

  //update dp
  Future<void> updateDp(String uid, String dp) async {
    return await userCollection.doc(uid).update({'dp': dp});
  }

  //update acc type
  Future<void> updateType(String uid, String type) async {
    return await userCollection.doc(uid).update({'type': type});
  }
}
