part of 'listing_bloc.dart';

abstract class ListingState extends Equatable {
  const ListingState();
  
  @override
  List<Object> get props => [];
}

class ListingInitial extends ListingState {}
