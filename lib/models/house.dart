class House {
  //instance variables
  String uid;
  String hostId;
  String name;
  String description;
  int bedrooms;
  int bathrooms;
  double price;
  double fee;
  String status;
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

  House({
    this.uid,
    this.hostId,
    this.name,
    this.description,
    this.bedrooms,
    this.bathrooms,
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

  House.fromMap(Map<String, dynamic> houseDocument)
      : hostId = houseDocument['hostId'],
        name = houseDocument['name'],
        description = houseDocument['description'],
        bedrooms = houseDocument['bedrooms'],
        bathrooms = houseDocument['bathrooms'],
        price = double.parse(houseDocument['price'].toString()),
        fee = double.parse(
          houseDocument['fee'].toString(),
        ),
        status = houseDocument['status'],
        available = houseDocument['available'],
        terms = houseDocument['terms'],
        likes = houseDocument['likes'],
        views = houseDocument['views'],
        category = houseDocument['category'],
        location = houseDocument['location'],
        review = double.parse(houseDocument['review'].toString()),
        images = houseDocument['images'],
        videos = houseDocument['videos'],
        amenities = houseDocument['amenities'],
        date = houseDocument['date'].toDate();
}
