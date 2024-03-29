class Apartment {
  //instance variables
  String uid;
  String hostId;
  String number;
  String description;
  int bedrooms;
  int bathrooms;
  Map<dynamic, dynamic> building;
  double price;
  String status;
  double fee;
  bool available;
  int terms;
  int likes;
  int views;
  Map<dynamic, dynamic> category;
  Map<dynamic, dynamic> location;
  double review;
  List<dynamic> images;
  List<dynamic> videos;
  List<dynamic> amenities;
  DateTime date;

  Apartment({
    this.uid,
    this.hostId,
    this.number,
    this.description,
    this.bedrooms,
    this.bathrooms,
    this.building,
    this.price,
    this.fee,
    this.status,
    this.views,
    this.available,
    this.terms,
    this.likes,
    this.category,
    this.location,
    this.review,
    this.images,
    this.videos,
    this.amenities,
    this.date,
  });

  Apartment.fromMap(Map<String, dynamic> apartmentDocument)
      : hostId = apartmentDocument['hostId'],
        number = apartmentDocument['number'],
        description = apartmentDocument['description'],
        bedrooms = apartmentDocument['bedrooms'],
        bathrooms = apartmentDocument['bathrooms'],
        building = apartmentDocument['building'],
        price = double.parse(apartmentDocument['price'].toString()),
        fee = double.parse(
          apartmentDocument['fee'].toString(),
        ),
        status = apartmentDocument['status'],
        available = apartmentDocument['available'],
        terms = apartmentDocument['terms'],
        likes = apartmentDocument['likes'],
        views = apartmentDocument['views'],
        category = apartmentDocument['category'],
        location = apartmentDocument['location'],
        review = double.parse(apartmentDocument['review'].toString()),
        images = apartmentDocument['images'],
        videos = apartmentDocument['videos'],
        amenities = apartmentDocument['amenities'],
        date = apartmentDocument['date'].toDate();
}
