import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:napanga/models/user.dart';
import 'package:napanga/services/repository.dart';

part 'listing_event.dart';
part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  ListingBloc() : super(ListingInitial());
  final Repository _repository = Repository();

  @override
  Stream<ListingState> mapEventToState(
    ListingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

  Stream<UserModel> get getCurrentUserStream =>
      _repository.getCurrentUserStream();
  Stream<QuerySnapshot> userHouses(String uid) =>
      _repository.getUserHouses(uid);
  Stream<QuerySnapshot> userApts(String uid) => _repository.getUserApts(uid);
  Future<void> updateType(String uid, String type) async {
    try {
      return _repository.updateType(uid, type);
    } catch (e) {
      return e;
    }
  }

  Future<File> chooseImage() async {
    try {
      return await _repository.chooseImage();
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future<File> chooseVideo() async {
    try {
      return await _repository.chooseVideo();
    } catch (e) {
      print(e.toString());
      return e;
    }
  }
}
