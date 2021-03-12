import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:napanga/models/user.dart';
import 'package:napanga/services/repository.dart';
import 'package:meta/meta.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreInitial());
  Repository _repository = Repository();

  @override
  Stream<ExploreState> mapEventToState(
    ExploreEvent event,
  ) async* {}

  Future<void> get logOut => _repository.logOut();

  Stream<List<QuerySnapshot>> get cityHomes => _repository.getCityHomes();
  Future<UserModel> get getCurrentUser => _repository.getCurrentUser();
  Stream<UserModel> get getCurrentUserStream =>
      _repository.getCurrentUserStream();
  Stream<UserModel> getUser(String uid) => _repository.getUser(uid);
  Stream<QuerySnapshot> getAptReviews(String uid) =>
      _repository.getAptReviews(uid);
  Stream<QuerySnapshot> getHouseReviews(String uid) =>
      _repository.getHouseReviews(uid);

  Future<File> chooseImage() async {
    try {
      return await _repository.chooseImage();
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future<void> uploadImage(
      {@required File imageFile, @required String uid}) async {
    try {
      return await _repository.uploadImage(imageFile: imageFile, uid: uid);
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future<void> updateType(String uid, String type) async {
    try {
      return _repository.updateType(uid, type);
    } catch (e) {
      return e;
    }
  }
}
