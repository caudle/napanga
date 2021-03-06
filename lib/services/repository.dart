import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:napanga/models/apartment.dart';
import 'package:meta/meta.dart';
import 'package:napanga/models/house.dart';
import 'package:napanga/models/user.dart';
import 'package:napanga/services/auth.dart';
import 'package:napanga/services/providers/network/firestore/user_db.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
import 'providers/network/firestore/apartment_db.dart';
import 'providers/network/firestore/house_db.dart';

class Repository {
  final UserDatabase _userDatabase = UserDatabase();
  final ApartmentDatabase _apartmentDatabase = ApartmentDatabase();
  final HouseDatabase _houseDatabase = HouseDatabase();
  final AuthService _authService = AuthService();

  //log out user
  Future<void> logOut() async {
    return await _authService.signOut();
  }

  //create user
  Future<void> createUser(UserModel userModel) async {
    return await _userDatabase.createUser(userModel);
  }

  //get current user
  Future<UserModel> getCurrentUser() async {
    return await _userDatabase.getCurrentUser();
  }

  //user stream
  Stream<UserModel> getCurrentUserStream() {
    return _userDatabase.getCurrentUserStream();
  }

  ////get user
  Future<UserModel> getUser(String uid) async {
    return await _userDatabase.getUser(uid);
  }

  //create apartment
  Future<void> createApartment({Apartment apartment}) async {
    return await _apartmentDatabase.createApartment(apartment);
  }

  //create house
  createHouse({House house}) {
    return _houseDatabase.createHouse(house);
  }

  //get all apartments
  Stream<QuerySnapshot> getAllApts() {
    return _apartmentDatabase.getAll();
  }

  //rget all houses
  Stream<QuerySnapshot> getAllHouses() {
    return _houseDatabase.getAll();
  }

  //get city apartments
  Stream<QuerySnapshot> getCityApts() {
    return _apartmentDatabase.getCity();
  }

  //get city houses
  Stream<QuerySnapshot> getCityHouses() {
    return _houseDatabase.getCity();
  }

  //get city homes
  Stream<List<QuerySnapshot>> getCityHomes() {
    List<QuerySnapshot> combiner(QuerySnapshot a, QuerySnapshot b) => [a, b];
    return CombineLatestStream.combine2<QuerySnapshot, QuerySnapshot,
            List<QuerySnapshot>>(
        _apartmentDatabase.getCity(), _houseDatabase.getCity(), combiner);
  }

  //get image
  Future<File> chooseImage() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile?.path == null) {
      return retrieveLostData(picker);
    }
    return File(pickedFile?.path);
  }

  //get lost data
  Future<File> retrieveLostData(ImagePicker picker) async {
    File file;
    final LostData lostData = await picker.getLostData();
    if (lostData.file != null) {
      file = File(lostData.file.path);
    }
    return file;
  }

  //upload dp image
  Future<void> uploadImage(
      {@required File imageFile, @required String uid}) async {
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('user')
        .child('images/${p.basename(imageFile?.path)}');
    await reference.putFile(imageFile).whenComplete(() async {
      await reference.getDownloadURL().then((value) async {
        await _userDatabase.updateDp(uid, value);
      });
    });
  }

  //upload home img
  Future uploadHomeImage(File file, {String home}) async {
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('$home')
        .child('images/${p.basename(file?.path)}');
    return await reference
        .putFile(file)
        .then((value) => value.ref.getDownloadURL());
  }

  //get video
  Future<File> chooseVideo() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);
    if (pickedFile?.path == null) {
      return retrieveLostData(picker);
    }
    return File(pickedFile?.path);
  }

  //upload vid
  Future uploadVideo(File file, {String home}) async {
    var uuid = Uuid();
    String text = uuid.v1();
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('$home')
        .child('videos/$text.mp4');
    return await reference
        .putFile(file, firebase_storage.SettableMetadata(contentType: 'mp4'))
        .then((value) => value.ref.getDownloadURL());
  }

  //get apts for a user
  Stream<QuerySnapshot> getUserApts(String uid) {
    return _apartmentDatabase.getUserApts(uid);
  }

  //get houses for user
  Stream<QuerySnapshot> getUserHouses(String uid) {
    return _houseDatabase.getUserHouses(uid);
  }

  //update acc type
  Future<void> updateType(String uid, String type) async {
    return _userDatabase.updateType(uid, type);
  }
}
