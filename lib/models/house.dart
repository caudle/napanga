class House {
  //instance variables
  String uid;
  String hostId;
  String name;
  String description;
  int bedrooms;
  int bathrooms;
  double price;
  String status;
  bool available;
  int terms;
  int likes;
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
    this.status,
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
        price = houseDocument['price'],
        status = houseDocument['status'],
        available = houseDocument['available'],
        terms = houseDocument['terms'],
        likes = houseDocument['likes'],
        category = houseDocument['category'],
        location = houseDocument['location'],
        review = houseDocument['review'],
        images = houseDocument['images'],
        videos = houseDocument['videos'],
        amenities = houseDocument['amenities'],
        date = houseDocument['date'].toDate();
}
