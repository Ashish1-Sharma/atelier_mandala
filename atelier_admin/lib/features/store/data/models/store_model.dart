class StoreModel {
  String title;
  String description;
  String imageUrl;
  String price;
  // String quantity;
  int users;
  String sId;
  String date;
  String location;
  List<dynamic> pickupTimings;
  bool isPublic;

  StoreModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    // required this.quantity,
    required this.sId,
    required this.users,
    required this.date,
    required this.pickupTimings,
    required this.location,
    required this.isPublic
  });

  // Factory method to create a StoreModel object from JSON
  factory StoreModel.fromMap(Map<String, dynamic> json) {
    return StoreModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: json['price'] ?? '',
      // quantity: json['quantity'] ?? '0',
      sId: json['sId'] ?? '',
      users: json['users'] ?? 0,
      date: json['date'] ?? '',
        pickupTimings:json['pickupTimings'],
        location: json['location'],
        isPublic: json['isPublic']
    );
  }

  // Method to convert a StoreModel object to JSON
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      // 'quantity': quantity,
      'sId' : sId,
      'users' : users,
      'date' : date,
      'pickupTimings' : pickupTimings,
      'location' : location,
      'isPublic' : isPublic
    };
  }
}
